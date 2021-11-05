{{ config(materialized='table') }}

with 
    credit_card as (
        select
        creditcard_sk 
        , creditcardid	
        from {{ref('dim_credit_card')}}
    )

, customer as (
        select
        customer_sk
        , customerid
        from {{ref('dim_customer')}}
    )

, email_address as (
        select
        emailaddress_sk 
        , emailaddressid
        from {{ref('dim_email_adress')}}
    )

, person_address as (
        select
        address_sk
        , addressid
        from {{ref('dim_person_adress')}}
)

, person as (
        select
        person_sk 
        , businessentityid
        from {{ref('dim_person')}}
)

, product as (
        select
        product_sk
        , productid
        from {{ref('dim_product')}}
)

, sales_reason as (
        select
        salesreason_sk
        , salesreasonid	
        from {{ref('dim_sale_reason')}}
)

, sales_order_detail as (
        select
        salesorderdetail_sk
        , orderqty		
        , unitprice		
        , unitpricediscount		
        from {{ref('dim_sales_order_detail')}}
)

, sales_territory as (
        select
        territory_sk
        , territoryid
        from {{ref('dim_sales_territory')}}
)

, sales_orders_with_sk as (
        select
        sales_salesorderheader.salesorderid
        , credit_card.creditcard_sk as creditcard_fk
        , customer.customer_sk as customer_fk
        , sales_territory.territory_sk as territory_fk
        , sales_salesorderheader.orderdate
        , sales_salesorderheader.duedate	
        , sales_salesorderheader.shipdate
        , sales_salesorderheader.freight		
        , sales_salesorderheader.totaldue
        , sales_salesorderheader.subtotal
        from {{ref('stg_salesordersheader')}} sales_salesorderheader
        left join credit_card credit_card on sales_salesorderheader.creditcardid = credit_card.creditcardid
        left join customer customer on sales_salesorderheader.customerid = customer.customerid
        left join sales_territory sales_territory on sales_salesorderheader.territoryid = sales_territory.territoryid
)

select * from sales_orders_with_sk