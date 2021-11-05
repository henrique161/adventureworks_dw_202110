{{ config(materialized='table') }}

with 
    credit_card as (
        select
        creditcard_sk 
        , creditcardid
        , cardtype	
        from {{ref('dim_credit_card')}}
    )

, customer as (
        select
        customer_sk
        , customerid
        from {{ref('dim_customer')}}
    )

, person_address as (
        select
        address_sk
        , addressid
        , city	
        , stateprovinceid
        from {{ref('dim_person_adress')}}
)

, person as (
        select
        person_sk 
        , businessentityid
        , firstname	
        , middlename	
        , lastname	
        from {{ref('dim_person')}}
)

, product as (
        select
        product_sk
        , salesorderid
        , productid
        , name
        from {{ref('dim_product')}}
)

, sales_reason as (
        select
        salesreason_sk
        , salesreasonid
        , salesorderid
        , name
        , reasontype	
        from {{ref('dim_sale_reason')}}
)

, sales_order_detail as (
        select
        salesorderdetail_sk
        , salesorderid
        , orderqty		
        , unitprice		
        , unitpricediscount
        , productid		
        from {{ref('dim_sales_order_detail')}}
)

, sales_territory as (
        select
        territory_sk
        , territoryid
        , name
        from {{ref('dim_sales_territory')}}
)

, sales_orders_with_sk as (
        select
        sales_salesorderheader.salesorderid
        , sales_order_detail.salesorderdetail_sk as salesorderdetail_fk
        , product.product_sk as product_fk
        , product.productid
        , product.name as product_name 
        , credit_card.creditcard_sk as creditcard_fk
        , credit_card.cardtype as card_type
        , customer.customer_sk as customer_fk
        , sales_territory.territory_sk as territory_fk
        , sales_territory.name as country
        , person_address.address_sk as address_sk
        , person_address.stateprovinceid
        , person_address.city
        , sales_reason.salesreason_sk as salesreason_fk
        , sales_reason.name as salesreason_name
        , sales_salesorderheader.orderdate
        , sales_salesorderheader.duedate	
        , sales_salesorderheader.shipdate
        , sales_salesorderheader.status
        , sales_salesorderheader.freight
        , sales_order_detail.unitprice
        , sales_order_detail.unitpricediscount
        , sales_order_detail.orderqty
        , sales_salesorderheader.totaldue
        , sales_salesorderheader.subtotal
        from {{ref('stg_salesordersheader')}} sales_salesorderheader
        left join credit_card credit_card on sales_salesorderheader.creditcardid = credit_card.creditcardid
        left join customer customer on sales_salesorderheader.customerid = customer.customerid
        left join sales_territory sales_territory on sales_salesorderheader.territoryid = sales_territory.territoryid
        left join sales_order_detail sales_order_detail on sales_salesorderheader.salesorderid = sales_order_detail.salesorderid
        left join sales_reason sales_reason on sales_salesorderheader.salesorderid = sales_reason.salesorderid
        left join product product on sales_salesorderheader.salesorderid = product.salesorderid
        left join person_address person_address on sales_salesorderheader.billtoaddressid = person_address.addressid
)

select * from sales_orders_with_sk