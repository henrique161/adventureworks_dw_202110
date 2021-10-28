with
    source_data as (
        select
            creditcardid		
            , cardtype		
            , cardnumber		
            , expmonth	
            , expyear
            , modifieddate		
    
        from {{ source('erpadventureworks20211028','sales_creditcard') }}
    )

select * from source_data