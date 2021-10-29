{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_person') }}
)
    , transformed as (
        select

            row_number() over (order by businessentityid) as person_sk -- auto incremental surrogate key
            , businessentityid
            , persontype	
            , namestyle	
            , title
            , firstname	
            , middlename	
            , lastname	
            , suffix
            , emailpromotion	
            , additionalcontactinfo
            , demographics	
        from staging     
)

select * from transformed