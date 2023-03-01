

with
    fhvdata as (
        select
            *,
            row_number() over (partition by dispathcing_base_num, pickup_datetime) as rn
        from `my-rides-ro`.`ro_dezoomcamp`.`fhv_tripdata`
        where dispathcing_base_num is not null
    )

select
    -- identifiers
    to_hex(md5(cast(coalesce(cast(dispathcing_base_num as 
    string
), '') || '-' || coalesce(cast(pickup_datetime as 
    string
), '') as 
    string
))) as fhvid,
    cast(dispathcing_base_num as integer) as dispatchid,
    cast(pulocationid as integer) as pickup_locationid,
    cast(dolocationid as integer) as dropoff_locationid

    -- timestampssdb
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,

    -- trip info
    cast(sr_flag as integer) as sr_flag,
    affiliated_base_number

from fhvdata
where rn = 1

-- dbt build --m <model.sql> --var 'is_test_run: false'
 limit 100 