{% macro check_primary_key_and_rename(source_name, table_name, default_order_column="some_default_column", new_primary_key_suffix="ID") %}
    {# Get the reference to the source table #}
    {%- set source_ref = source(source_name, table_name) -%}

    {# Get the columns in the source 
    {%- set columns = adapter.get_columns_in_relation(source_ref) -%}

    {# Check if there are any columns #}
    {%- if columns | length > 0 -%}
        {# Get the first column name #}
        {%- set first_column = columns[0].name -%}

        {# Determine the name of the new primary key #}
        {%- set new_primary_key = source_name ~ "_" ~ table_name ~ "_" ~ new_primary_key_suffix -%}

        {# Define a valid ordering column (a neutral or safe one) #}
        {%- set order_by_column = default_order_column -%}
        {%- if default_order_column not in columns | map(attribute='name') %}
            {# If the default order column doesnt exist, fallback to the first column #}
            {%- set order_by_column = first_column -%}
        {%- endif -%}

        {# Check if the first column contains "ID" #}
        {%- if "ID" in first_column.upper() -%}
            {# If the first column contains "ID", rename it to the new format #}
            select 
                {{ first_column }} as {{ new_primary_key }},
                {{ "* " if columns | length > 1 else "" }} 
            from {{ source_ref }}
        {%- else -%}
            {# If the first column doesnt contain "ID", add a new primary key at the beginning #}
            select
                row_number() over (order by {{ order_by_column }}) as {{ new_primary_key }},
                *
            from {{ source_ref }}
        {%- endif -%}
    {%- else -%}
        {# Handle the case where no columns are present #}
        select 'No columns present in the table' as error_message
    {%- endif -%}
{% endmacro %}
