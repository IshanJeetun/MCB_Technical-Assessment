-- 3 queries below
SELECT DISTINCT orders.order_ref, orders.ORDER_DATE, suppliers.supplier_name, order_items.ORDER_ITEM_TOTAL_AMOUNT, invoices.INVOICE_REF, invoice_details.INVOICE_DETAILS_AMOUNT, invoice_details.INVOICE_DETAILS_STATUS FROM
(((orders join suppliers on suppliers.SUPPLIER_ID = orders.SUPPLIER_ID) 
join order_items on order_items.ORDER_ID = orders.ORDER_ID)
join invoice_details on invoice_details.INVOICE_ID = order_items.INVOICE_ID)
join invoices on invoice_details.INVOICE_ID = invoices.invoice_id;

SELECT DISTINCT orders.order_ref, orders.ORDER_DATE, suppliers.supplier_name, order_items.ORDER_ITEM_TOTAL_AMOUNT, invoices.INVOICE_REF, invoice_details.INVOICE_DETAILS_AMOUNT, invoice_details.INVOICE_DETAILS_STATUS FROM
((((orders join suppliers on suppliers.SUPPLIER_ID = orders.SUPPLIER_ID) 
join order_items on order_items.ORDER_ID = orders.ORDER_ID)
join invoice_details on invoice_details.INVOICE_ID = order_items.INVOICE_ID)
join invoices on invoice_details.INVOICE_ID = invoices.invoice_id)
order by order_items.ORDER_ITEM_TOTAL_AMOUNT desc limit 3;


SELECT suppliers.SUPPLIER_NAME, suppliers.SUPP_CONTACT_NAME, suppliers.SUPP_NUMBER1, suppliers.SUPP_NUMBER2, count(order_items.ORDER_ITEM_ID) as total_orders, sum(order_items.ORDER_ITEM_TOTAL_AMOUNT) as total_amount FROM
((suppliers join orders on suppliers.SUPPLIER_ID = orders.SUPPLIER_ID) join 
order_items on orders.ORDER_ID = order_items.ORDER_ITEM_ID)
where orders.ORDER_DATE BETWEEN STR_TO_DATE("01-01-2017",'%d-%m-%Y') and STR_TO_DATE("31-08-2017",'%d-%m-%Y') 
GROUP by (suppliers.SUPPLIER_NAME);