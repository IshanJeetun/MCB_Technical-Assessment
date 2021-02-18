-- 3 queries below
SELECT DISTINCT CAST(Right(orders.order_ref,3) AS UNSIGNED) as "Order Reference", orders.ORDER_DATE as "Order Period", suppliers.supplier_name as "Supplier Name", order_items.ORDER_ITEM_TOTAL_AMOUNT as "Order Total Amount", order_items.ORDER_ITEM_STATUS as "Order Status", invoices.INVOICE_REF as "Invoice Reference", invoice_details.INVOICE_DETAILS_AMOUNT as "Invoice Total Amount", invoice_details.INVOICE_DETAILS_STATUS as "Invoice Status" FROM
(((orders join suppliers on suppliers.SUPPLIER_ID = orders.SUPPLIER_ID) 
join order_items on order_items.ORDER_ID = orders.ORDER_ID)
join invoice_details on invoice_details.INVOICE_ID = order_items.INVOICE_ID)
join invoices on invoice_details.INVOICE_ID = invoices.invoice_id


SELECT  CAST(Right(orders.order_ref,3) AS UNSIGNED) as "Order Reference", orders.ORDER_DATE as "Order Date",suppliers.supplier_name as "Supplier Name", order_items.ORDER_ITEM_TOTAL_AMOUNT as "Order Total Amount", order_items.ORDER_ITEM_STATUS as "Order Status", invoices.INVOICE_REF as "Invoice Reference" FROM
((((orders join suppliers on suppliers.SUPPLIER_ID = orders.SUPPLIER_ID) 
join order_items on order_items.ORDER_ID = orders.ORDER_ID)
join invoice_details on invoice_details.INVOICE_ID = order_items.INVOICE_ID)
join invoices on invoice_details.INVOICE_ID = invoices.invoice_id)
order by order_items.ORDER_ITEM_TOTAL_AMOUNT desc limit 3


SELECT suppliers.SUPPLIER_NAME as "Supplier Name", suppliers.SUPP_CONTACT_NAME as "Supplier Contact Name", suppliers.SUPP_NUMBER1 as "Supplier Contact Number 1", suppliers.SUPP_NUMBER2 as "Supplier Contact Number 2", count(order_items.ORDER_ITEM_ID) as "Total Orders", sum(order_items.ORDER_ITEM_TOTAL_AMOUNT) as "Order Total Amount" FROM
((suppliers join orders on suppliers.SUPPLIER_ID = orders.SUPPLIER_ID) join 
order_items on orders.ORDER_ID = order_items.ORDER_ITEM_ID)
where orders.ORDER_DATE BETWEEN STR_TO_DATE("01-01-2017",'%d-%m-%Y') and STR_TO_DATE("31-08-2017",'%d-%m-%Y') 
GROUP by (suppliers.SUPPLIER_NAME)