-- functions used for data cleaning
DELIMITER $$
CREATE FUNCTION correct(x varchar(200)) RETURNS int
BEGIN 
    DECLARE temp VARCHAR(255) DEFAULT null;
    DECLARE output int DEFAULT null;
    SET temp = REPLACE(x, "o", "0");
    SET temp = REPLACE(temp, "O", "0");
    SET temp = REPLACE(temp, "i", "1");
    SET temp = REPLACE(temp, "I", "1");
    SET temp = REPLACE(temp, "z", "2");
    SET temp = REPLACE(temp, "Z", "2");
    SET temp = REPLACE(temp, "s", "5");
    SET temp = REPLACE(temp, "S", "5");
	SET temp = REPLACE(temp, "b", "6");
	SET temp = REPLACE(temp, ",", "");
	SET output = CONVERT(temp,UNSIGNED INTEGER);
    return output;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION corrects(x varchar(200)) RETURNS  varchar(200)
BEGIN 
    DECLARE temp VARCHAR(200) DEFAULT null;
    SET temp = REPLACE(x, "o", "0");
    SET temp = REPLACE(temp, "O", "0");
    SET temp = REPLACE(temp, "i", "1");
    SET temp = REPLACE(temp, "I", "1");
    SET temp = REPLACE(temp, "z", "2");
    SET temp = REPLACE(temp, "Z", "2");
    SET temp = REPLACE(temp, "s", "5");
    SET temp = REPLACE(temp, "S", "5");
	SET temp = REPLACE(temp, "b", "6");
    SET temp = REPLACE(temp, ".", "");
    return temp;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION convert_date(x varchar(200)) RETURNS  varchar(200)
BEGIN 
    DECLARE temp VARCHAR(200) DEFAULT null;
    SET temp = REPLACE(x, "FEB", "02");
    SET temp = REPLACE(temp, "JAN", "01");
    SET temp = REPLACE(temp, "MAR", "03");
    SET temp = REPLACE(temp, "APR", "03");
    SET temp = REPLACE(temp, "MAY", "05");
    SET temp = REPLACE(temp, "JUN", "06");
    SET temp = REPLACE(temp, "JUL", "07");
    SET temp = REPLACE(temp, "AUG", "08");
    SET temp = REPLACE(temp, "SEP", "09");
    SET temp = REPLACE(temp, "OCT", "10");
    SET temp = REPLACE(temp, "NOV", "11");
    SET temp = REPLACE(temp, "DEC", "12");
    return temp;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION correctsNum(x varchar(200)) RETURNS  varchar(200)
BEGIN 
    DECLARE temp VARCHAR(200) DEFAULT null;
    SET temp = REPLACE(x, "o", "0");
    SET temp = REPLACE(temp, "O", "0");
    SET temp = REPLACE(temp, "i", "1");
    SET temp = REPLACE(temp, "I", "1");
    SET temp = REPLACE(temp, "z", "2");
    SET temp = REPLACE(temp, "Z", "2");
    SET temp = REPLACE(temp, "s", "5");
    SET temp = REPLACE(temp, "S", "5");
	SET temp = REPLACE(temp, "b", "6");
    SET temp = REPLACE(temp, ".", "");
	SET temp = REPLACE(temp, ",", "");
    return temp;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION action(x varchar(200)) RETURNS  varchar(200)
BEGIN 
    DECLARE temp VARCHAR(200) DEFAULT null;
    SET temp = REPLACE(x, "Paid", "Ok");
    SET temp = REPLACE(x, "Pending", "To follow up");
    SET temp = REPLACE(x, "", "To verify");
    return temp;
END$$
DELIMITER ;