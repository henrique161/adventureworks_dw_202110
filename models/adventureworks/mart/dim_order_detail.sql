{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_salesorderdetail') }}
)
    , transformed as (
        select

           row_number() over (order by salesorderdetailid) as orderdetail_sk -- auto incremental surrogate key
            , salesorderid		
            , salesorderdetailid		
            , carriertrackingnumber		
            , orderqty	
            , productid		
            , specialofferid		
            , unitprice		
            , unitpricediscount					
        from staging     
)

select * from transformed