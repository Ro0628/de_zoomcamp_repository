
  
    

    create or replace table `my-rides-ro`.`ro_dezoomcamp`.`fact_fhv_trip`
    
    
    OPTIONS()
    as (
      

with fhv_data as (
    select *, 
        'FHV' as service_type 
    from `my-rides-ro`.`ro_dezoomcamp`.`stg_fhv_tripdata`
),

dim_zones as (
    select * from `my-rides-ro`.`ro_dezoomcamp`.`dim_zones`
    where borough != 'Unknown'
)
select 
    fhvid,
    dispatching_base_num,
    pickup_datetime,
    dropoff_datetime,
    fhv_data.PUlocationID, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    fhv_data.DOlocationID,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    SR_Flag,
    affiliated_base_number
from fhv_data
inner join  dim_zones as pickup_zone
on fhv_data.PUlocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_data.DOlocationid = dropoff_zone.locationid
    );
  