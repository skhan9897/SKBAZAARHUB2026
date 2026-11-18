provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name = "${var.project_name}-${var.environment}"
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)
  tags = {
    Project     = "SK BazaarHub"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name               = local.name
  cidr               = "10.40.0.0/16"
  azs                = local.azs
  private_subnets    = ["10.40.1.0/24", "10.40.2.0/24"]
  public_subnets     = ["10.40.101.0/24", "10.40.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = local.tags
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${local.name}-db-subnets"
  subnet_ids = module.vpc.private_subnets
  tags       = local.tags
}

resource "aws_security_group" "postgres" {
  name        = "${local.name}-postgres"
  description = "PostgreSQL access only from application security group; add app SG rules during ECS phase"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "No public ingress. Application security group rule will be added in compute phase."
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    self        = true
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.tags
}

resource "aws_db_instance" "postgres" {
  identifier              = "${local.name}-postgres"
  engine                  = "postgres"
  engine_version          = "16"
  instance_class          = "db.t4g.micro"
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type            = "gp3"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.postgres.name
  vpc_security_group_ids  = [aws_security_group.postgres.id]
  publicly_accessible     = false
  multi_az                = false
  storage_encrypted       = true
  backup_retention_period = 7
  deletion_protection     = true
  skip_final_snapshot     = false
  final_snapshot_identifier = "${local.name}-final"
  auto_minor_version_upgrade = true
  tags = local.tags
}

resource "aws_ecr_repository" "platform" {
  name                 = "${local.name}/platform-service"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration { scan_on_push = true }
  tags = local.tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "ecr_platform_repository_url" {
  value = aws_ecr_repository.platform.repository_url
}
