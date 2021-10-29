with
    source_data as (
        select
            productid		
            , name		
            , productnumber		
            , makeflag
            , finishedgoodsflag
            , color
            , safetystocklevel
            , reorderpoint
            , standardcost
            , listprice
            , size
            , sizeunitmeasurecode
            , weightunitmeasurecode
            , weight	
            , daystomanufacture	
            , productline
            , class
            , style
            , productsubcategoryid	
            , productmodelid	
            , sellstartdate	
            , sellenddate
            , discontinueddate	
            , rowguid
            , modifieddate	
    
        from {{ source('erpadventureworks20211028','production_product') }}
    )

select * from source_data