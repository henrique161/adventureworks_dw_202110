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

    , source_data_2 as (
        select
            businessentityid
            , persontype	
            , namestyle	
            , title
            , firstname	
            , middlename	
            , lastname	
            , suffix
    
        from {{ source('erpadventureworks20211028','person_person') }}
    )

select *
from source_data_2 
left join source_data on source_data_2.businessentityid =  source_data.personid