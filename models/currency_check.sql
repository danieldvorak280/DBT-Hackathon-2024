{{ config(materialized='table') }}
-- depends_on: {{ ref('PIZZA_CUSTOMERS') }}
{{ check_currency('PIZZA_CUSTOMERS') }}