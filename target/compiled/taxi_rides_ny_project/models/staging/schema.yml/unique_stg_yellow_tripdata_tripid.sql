
    
    

with dbt_test__target as (

  select tripid as unique_field
  from `my-rides-ro`.`ro_dezoomcamp`.`stg_yellow_tripdata`
  where tripid is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


