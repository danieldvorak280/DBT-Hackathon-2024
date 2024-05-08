{% macro add_timezone_columns(table_name, timezone='Europe/Prague') %}
    {%- set target_table = ref(table_name) -%}
    
    {# Query to fetch all column names except "ID" from the target table #}
    {%- set columns_query %}
        SELECT 
            column_name 
        FROM 
            information_schema.columns
        WHERE 
            column_name != 'ID'
    {%- endset %}

    -- Execute the query to get the list of columns except "ID"
    {%- set columns = run_query(columns_query) -%}

    {# Query to fetch all columns of Timestamp_NTZ type from the target table #}
    {%- set timestamp_columns_query %}
        SELECT 
            column_name 
        FROM 
            information_schema.columns
        WHERE 
            data_type = 'Timestamp_NTZ'
    {%- endset %}

    -- Execute the query to get the list of timestamp columns
    {%- set timestamp_columns = run_query(timestamp_columns_query) -%}

    -- Define the base SELECT statement with existing columns
    SELECT 
        * 
    FROM 
        {{ target_table }}
    
    {# Iterate through the timestamp columns and add timezone-adjusted columns #}
    {%- for row in timestamp_columns %}
        , {{ row.column_name }} AT TIME ZONE '{{ timezone }}' AS {{ row.column_name }}_with_timezone
    {%- endfor %}
{% endmacro %}


