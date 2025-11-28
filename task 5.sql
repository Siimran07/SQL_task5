CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    price FLOAT,
    stock INT
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop', 45000, 5),
('Mouse', 300, 50),
('Keyboard', 1200, 20),
('Monitor', 8500, 8),
('USB Cable', 150, 100);

CREATE OR REPLACE FUNCTION price_category(price FLOAT)
RETURNS VARCHAR AS $$
DECLARE p_cat TEXT;
BEGIN
    IF price < 500 THEN
        p_cat := 'Low';
    ELSIF price < 2000 THEN
        p_cat := 'Medium';
    ELSIF price < 10000 THEN
        p_cat := 'High';
    ELSE
        p_cat := 'Premium';
    END IF;

    RETURN p_cat;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM products;

SELECT price_category(200);   
SELECT price_category(1500);  
SELECT price_category(6000);  
SELECT price_category(20000); 

CREATE OR REPLACE FUNCTION stock_status(stock INT)
RETURNS VARCHAR AS $$
DECLARE s_status TEXT;
BEGIN
    IF stock <= 5 THEN
        s_status := 'Critical';
    ELSIF stock <= 20 THEN
        s_status := 'Low';
    ELSIF stock <= 50 THEN
        s_status := 'Normal';
    ELSE
        s_status := 'High';
    END IF;

    RETURN s_status;
END;
$$ LANGUAGE plpgsql;

SELECT stock_status(3);    
SELECT stock_status(15);   
SELECT stock_status(40);   
SELECT stock_status(100); 

SELECT 
    product_id,
    product_name,
    price,
    stock,
    price_category(price) AS price_level,
    stock_status(stock) AS stock_level
FROM products;

ALTER TABLE products
ADD COLUMN price_level VARCHAR,
ADD COLUMN stock_level VARCHAR;

UPDATE products SET
    price_level = price_category(price),
    stock_level = stock_status(stock);

SELECT * FROM products;
