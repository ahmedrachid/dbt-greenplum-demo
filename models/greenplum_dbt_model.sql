
{% set fields_string %}
     time timestamp NULL,
     device_id int null,
     cpu_usage double precision
{% endset %}

{% set raw_partition %}
    PARTITION BY RANGE (time)
    (
        START ('2022-06-01'::timestamp) INCLUSIVE
        END ('2024-01-01'::timestamp) EXCLUSIVE
        EVERY (INTERVAL '1 day'),
        DEFAULT PARTITION extra
    );
{% endset %}

{{
    config(
        materialized='table',
        distributed_by='device_id',
        appendonly='true',
        orientation='column',
        compresstype='ZLIB',
        compresslevel=3,
        fields_string=fields_string,
        raw_partition=raw_partition,
        default_partition_name='other_data'
    )
}}

with source_data as (

    SELECT time, device_id, random()*100 as cpu_usage
    FROM generate_series(
      now() - INTERVAL '6 months',
       now(),
       INTERVAL '1 minute'
      ) as time,
    generate_series(1,1000) device_id

)
select *
from source_data