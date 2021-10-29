with
    source_data as (
        select
            customerid	
            , personid	
            , storeid	
            , territoryid	
            , rowguid	
            , modifieddate
    
        from {{ source('erpadventureworks20211028','sales_customer') }}
    )

select * from source_data