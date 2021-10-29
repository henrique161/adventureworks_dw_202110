with
    source_data as (
        select
            salesreasonid	
            , name	
            , reasontype
            , modifieddate	
    
        from {{ source('erpadventureworks20211028','sales_salesreason') }}
    )

select * from source_data