{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_salesordersheader') }}
)
    , transformed as (
        select

           row_number() over (order by salesorderid) as order_sk -- auto incremental surrogate key
            , salesorderid			
            , orderdate
            , duedate	
            , shipdate
            , status	
            , purchaseordernumber	
            , accountnumber			
            , subtotal		
            , taxamt		
            , freight		
            , totaldue					
        from staging     
)

select * from transformed