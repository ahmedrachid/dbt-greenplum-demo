
{{ disable_gporca() }}

{{ config(materialized='table') }}

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