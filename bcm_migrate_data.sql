-- migrating into 5 newly created tables
INSERT into suppliers (SUPPLIER_NAME, SUPP_CONTACT_NAME, SUPP_ADDRESS, SUPP_NUMBER1, SUPP_EMAIL)
SELECT DISTINCT SUPPlIER_NAME, SUPP_CONTACT_NAME, SUPP_ADDRESS, corrects(SUPP_CONTACT_NUMBER), SUPP_EMAIL from xxbcm_order_mgt;
UPDATE suppliers set 
        supp_number2 = case when (SUBSTRING_INDEX(SUBSTRING_INDEX(SUPP_NUMBER1, ',', 2), ',', -1) != SUBSTRING_INDEX(SUBSTRING_INDEX(SUPP_NUMBER1, ',', 1), ',', -1)) THEN            SUBSTRING_INDEX(SUBSTRING_INDEX(SUPP_NUMBER1, ',', 2), ',', -1)
        else Null
        end;
UPDATE suppliers set supp_number1 = (SELECT  SUBSTRING_INDEX(SUBSTRING_INDEX(SUPP_NUMBER1, ',', 1), ',', -1));
UPDATE suppliers set supp_number1 = (select REPLACE(supp_number1, " ", ""));
UPDATE suppliers set supp_number2 = (select REPLACE(supp_number2, " ", ""));


INSERT into invoices (INVOICE_REF)
SELECT DISTINCT INVOICE_REFERENCE from xxbcm_order_mgt order by INVOICE_REFERENCE;
DELETE FROM `invoices` WHERE `invoices`.`INVOICE_REF` = "";


INSERT into orders (ORDER_REF, ORDER_DATE, SUPPLIER_ID)
SELECT DISTINCT left(ORDER_REF,5), STR_TO_DATE(convert_date(ORDER_DATE),'%d-%m-%Y'), (SELECT supplier_id from suppliers WHERE suppliers.supplier_name = xxbcm_order_mgt.SUPPLIER_NAME) as invoice_id from xxbcm_order_mgt where invoice_reference is not null;


insert into invoice_details (invoice_details_amount, invoice_details_date, invoice_details_status,invoice_id)
SELECT correctsNum(INVOICE_AMOUNT), STR_TO_DATE(convert_date(INVOICE_DATE),'%d-%m-%Y'), invoice_status,(SELECT invoice_id from invoices where xxbcm_order_mgt.INVOICE_REFERENCE = invoices.invoice_ref) from xxbcm_order_mgt where xxbcm_order_mgt.INVOICE_REFERENCE is not null;


insert into order_items (ORDER_ITEM_DESCRIPTION, ORDER_ITEM_STATUS, ORDER_ITEM_LINE_AMOUNT, ORDER_ITEM_TOTAL_AMOUNT, INVOICE_ID, ORDER_ID)
SELECT ORDER_DESCRIPTION, order_status, correctsNum(order_line_amount), correctsNum(order_total_amount), (SELECT INVOICE_ID from invoices where xxbcm_order_mgt.INVOICE_REFERENCE = invoices.INVOICE_REF), (SELECT order_id from orders where left(xxbcm_order_mgt.ORDER_REF,5) = orders.ORDER_REF) from xxbcm_order_mgt;

