{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_emailadress') }}
)
    , transformed as (
        select

           row_number() over (order by emailaddressid) as emailaddress_sk -- auto incremental surrogate key
            , businessentityid
            , emailaddressid
            , emailaddress
            , rowguid
            , modifieddate				
        from staging     
)

select * from transformed