Hevo ELT Assignment – Postgres to Snowflake using dbt
Overview

This project demonstrates an end-to-end ELT pipeline implementation using:

PostgreSQL as the source database

Hevo Data for data ingestion

Snowflake as the destination data warehouse

dbt (Data Build Tool) for data transformation

The objective was to ingest raw data into Snowflake and build a transformed customers mart model using dbt following best practices.

Architecture

PostgreSQL → Hevo Data → Snowflake (RAW layer) → dbt (Staging + Mart models)

Source tables are created in PostgreSQL.

Hevo replicates the tables into Snowflake under the RAW__PUBLIC schema.

dbt builds:

Staging models

Final mart model (customers)

Tests are applied to validate data quality.

Project Structure
models/
│
├── staging/
│   ├── stg_customers.sql
│   ├── stg_orders.sql
│   └── stg_payments.sql
│
├── marts/
│   └── customers.sql
│
└── schema.yml

Staging Layer

Cleans and standardizes raw data

Removes technical columns from Hevo

Renames fields consistently

Mart Layer

Builds the final customers model

Aggregates order and payment information per customer

Ensures data integrity using tests

Data Models
1. Staging Models

stg_customers

stg_orders

stg_payments

These models reference raw tables from Snowflake using dbt source() definitions.

2. Final Model

customers

This model:

Joins customers with orders and payments

Aggregates total orders and total payments

Applies data quality tests:

not_null

unique

Data Quality Tests

Defined in schema.yml:

customer_id is:

Not null

Unique

All tests pass successfully.

Security & Configuration

This project follows secure configuration practices:

No credentials are hardcoded in the repository.

Snowflake password is injected via environment variable:

password: "{{ env_var('SNOWFLAKE_PASSWORD') }}"


profiles.yml is stored outside the project directory.

Sensitive information (passwords, access keys, URLs) is excluded from Git tracking via .gitignore.

This ensures compliance with the assignment’s security guidelines.

How to Run
1. Set Environment Variable

PowerShell:

setx SNOWFLAKE_PASSWORD "your_password"


Restart terminal.

2. Run dbt
dbt debug
dbt run
dbt test


Expected result:

All models built successfully

All tests passed

Assignment Completion Status

Hevo pipeline created successfully

Data replicated from PostgreSQL to Snowflake

dbt staging models built

Final customers mart built

Tests implemented and passing

Credentials secured and excluded from repository
