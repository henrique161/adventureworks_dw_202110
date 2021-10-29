with
    source_data as (
        select
            businessentityid
            , emailaddressid
            , emailaddress
            , rowguid
            , modifieddate
    
        from {{ source('erpadventureworks20211028','person_emailaddress') }}
    )

select * from source_data