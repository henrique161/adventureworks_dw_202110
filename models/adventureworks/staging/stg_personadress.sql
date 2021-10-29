with
    source_data as (
        select
            addressid		
            , addressline1		
            , addressline2		
            , city	
            , stateprovinceid		
            , postalcode	
            , spatiallocation		
            , rowguid	
            , modifieddate	
    
        from {{ source('erpadventureworks20211028','person_address') }}
    )

select * from source_data