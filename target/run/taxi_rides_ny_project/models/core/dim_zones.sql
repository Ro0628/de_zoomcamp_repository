
  
    

    create or replace table `my-rides-ro`.`ro_dezoomcamp`.`dim_zones`
    
    
    OPTIONS()
    as (
      

select locationid, borough, zone, replace(service_zone, 'Boro', 'Green') as service_zone
from `my-rides-ro`.`ro_dezoomcamp`.`taxi_zone_lookup`
    );
  