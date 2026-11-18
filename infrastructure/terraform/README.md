# AWS infrastructure starter

This Terraform starter provisions a VPC, private RDS PostgreSQL instance, and ECR repository.

IMPORTANT:
- AWS resources cost money, including NAT Gateway and RDS.
- Review `terraform plan` before `terraform apply`.
- Use an AWS deployment role with least privilege.
- Supply `TF_VAR_db_password` through a secure local shell or CI secret.
- Do not commit state files, passwords, access keys, or real tfvars.
- ECS, load balancer, Kafka/MSK, Redis, S3, SES, Secrets Manager, and monitoring are added in later phases.
- This initial RDS security group has no public ingress. ECS application security group connectivity is added with the compute phase.
