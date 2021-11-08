{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_salescustomer') }}
)
    , transformed as (
        select

            row_number() over (order by customerid) as customer_sk -- auto incremental surrogate key
            , customerid
            , firstname	
            , middlename	
            , lastname		
            , personid	
            , storeid	
            , territoryid			
        from staging     
)

select * from transformed