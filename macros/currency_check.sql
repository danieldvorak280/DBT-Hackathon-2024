{#{% macro remove_id_column(columns) %}
    {%- set filtered_columns = [] -%}
    {%- for col in columns -%}
        {%- if col.name.lower() != 'id' -%}
            {%- set _ = filtered_columns.append(col.name) -%}
        {%- endif -%}
    {%- endfor -%}
    {{ filtered_columns | join(', ') }}
{% endmacro %}
{% macro check_currency(model_name) %}
    {%- set model_ref = ref(model_name) -%}
    {%- set columns = adapter.get_columns_in_relation(model_ref) -%}
    {%- set currency_codes = var('currency_codes') -%}
    {%- if columns | length > 0 -%}
        {%- set currency_found = false -%}
        {%- set found_currency = None -%}
        {%- for col in columns -%}
            {%- set col_name_lower = col.name.lower() -%}
            {%- for code in currency_codes -%}
                {%- set code_lower = code.lower() -%}
                {%- if code_lower in col_name_lower -%}
                    {%- set currency_found = true -%}
                    {%- set found_currency = code -%}
                    {%- break -%}
                {%- endif -%}
            {%- endfor -%}
            {%- if currency_found -%}
                {%- break -%}
            {%- endif -%}
        {%- endfor -%}
        {%- if currency_found -%}
            SELECT
                {{ remove_id_column(columns) }},
                '{{ found_currency }}' AS Currency
            FROM {{ model_ref }}
        {%- else -%}
            SELECT
                {{ remove_id_column(columns) }},
                'None' AS Currency
            FROM {{ model_ref }}
        {%- endif -%}
    {%- else -%}
        SELECT 'No columns present in the table' AS error_message
    {%- endif -%}
{% endmacro %}

#}