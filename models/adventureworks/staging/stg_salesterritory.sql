with
    source_data as (
        select
            territoryid
            , name
            , countryregioncode
            , salesytd
            , saleslastyear
            , costytd
            , costlastyear	
            , rowguid
            , modifieddate
    
        from {{ source('erpadventureworks20211028','sales_salesterritory') }}
    )

select * from source_data