

  create or replace view `my-rides-ro`.`ro_dezoomcamp`.`stg_fhv_tripdata`
  OPTIONS()
  as 

with fhvdata as (
        select
            *, row_number() over (partition by dispatching_base_num, pickup_datetime) as rn
        from `my-rides-ro`.`ro_dezoomcamp`.`fhv_external`
        where dispatching_base_num is not null
    )
select
    -- identifiers
    to_hex(md5(cast(coalesce(cast(dispatching_base_num as 
    string
), '') || '-' || coalesce(cast(pickup_datetime as 
    string
), '') as 
    string
))) as fhvid,
    *
from fhvdata
where rn = 1

-- dbt build --m <model.sql> --var 'is_test_run: false'
;

