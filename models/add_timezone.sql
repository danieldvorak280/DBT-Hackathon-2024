{{ config(materialized='table') }}
{{ add_timezone_columns("PIZZA_CUSTOMERS") }}