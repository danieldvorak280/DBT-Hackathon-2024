{{ config(materialized='table') }}
{{ check_primary_key_and_rename("TEAM_01_ALL", "PIZZA_ORDER_ITEM_TOPPINGS") }}
