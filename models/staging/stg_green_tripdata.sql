{{ config(materialized="view") }} select * from {{source('staging', 'green_rides')}} limit 100
