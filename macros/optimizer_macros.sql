{% macro disable_gporca() %}

  {% set query %}
    set optimizer=off
  {% endset %}

  {% do run_query(query) %}
{% endmacro %}


{% macro enable_gporca() %}

  {% set query %}
    set optimizer = on
  {% endset %}

  {% do run_query(query) %}
{% endmacro %}