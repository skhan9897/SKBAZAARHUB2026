CREATE SCHEMA IF NOT EXISTS platform;

CREATE TABLE platform.schema_migration_check (
    id BIGSERIAL PRIMARY KEY,
    component VARCHAR(80) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO platform.schema_migration_check(component)
VALUES ('platform-service')
ON CONFLICT (component) DO NOTHING;
