{% macro check_and_alter_primary_key(model_name, new_primary_key="ID") %}
    {%- set model_ref = ref(model_name) -%}
    {%- set columns = adapter.get_columns_in_relation(model_ref) -%}
    -- Check if there are any columns returned
    {%- if columns | length > 0 -%}
        {%- set first_column = columns[0].name -%}
        -- Check if the first column contains "ID"
        {%- if "ID" in first_column.upper() -%}
            -- No need to add a new primary key column
            select * from {{ model_ref }}
        {%- else -%}
            -- Create a new primary key column at the beginning
            select row_number() over (order by {{ first_column }}) as {{ new_primary_key }}, *
            from {{ model_ref }}
        {%- endif -%}
    {%- else -%}
        -- Handle the case where no columns are present
        select 'No columns present in the table' as error_message
    {%- endif -%}
{% endmacro %}