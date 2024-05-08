{{ config(materialized='table') }}
{{ check_primary_key_and_rename("TEAM_01_ALL", "PIZZA_CUSTOMERS") }}
{{ check_currency('HACKATHON.TEAM_01.PIZZA_CUSTOMERS') }}
