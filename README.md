Welcome to your new dbt project!

<!-- So dbt is only where you will built your sql transformation and the data will be saved
to snowflake -->

### Using the starter project

Try running the following commands:
- dbt parse
- dbt run
- dbt test


How dbt creates tables in Snowflake automatically:

{{ config(materialized='table') }}

SQL query to be executed

- Above things is equivalent to the below:

CREATE OR REPLACE TABLE DBT_DB.DBT_DEV_AMAN.PRODUCTS_CLEAN AS
SELECT ...

- write the above config things and it will create the table at the below path:

- 1.run the command(dbt run --select products_clean) to execute below script
- 2.check the written table in: SELECT * FROM DBT_DB.DBT_DEV_AMAN.PRODUCTS_CLEAN;
- 3.DBT_DEV_AMAN is the schema defined in dbt env connection.




=> Re-run behavior

Each run does:

- Materialization	          Behavior
- table	               Drop + recreate
- view	               Replace view
- incremental	           Append/update rows



- Raw ---> Staging ---> marts

models/
│
├── staging/
│   └── stg_products.sql
│
├── marts/
│   └── products_clean.sql
│
└── schema.yml



### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
