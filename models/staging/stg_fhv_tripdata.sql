{{ config(materialized="view") }}

with fhvdata as (
        select
            *, row_number() over (partition by dispatching_base_num, pickup_datetime) as rn
        from {{ source("staging", "fhv") }}
        where dispatching_base_num is not null
    )
select
    -- identifiers
    {{ dbt_utils.surrogate_key(["dispatching_base_num", "pickup_datetime"]) }} as fhvid,
    *
from fhvdata
where rn = 1

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}
    limit 100
{% endif %}