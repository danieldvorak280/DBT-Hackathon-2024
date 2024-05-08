{{ config(materialized='table') }}
{{ check_primary_key_and_rename("TEAM_01_ALL", "PIZZA_MARKETING_EXPENDITURES") }}
