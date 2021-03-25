/* 
 Типы ассоциации
 
 1 => : <= 1 
 1  : <= m   
 m : <= m_to_n => : n
 
 <= - REFERENCES
 */
CREATE TABLE "phones"(
  id serial PRIMARY KEY,
  brand varchar(64) NOT NULL,
  model varchar(64) NOT NULL,
  price decimal(10, 2) NOT NULL CHECK (price > 0),
  quantity int NOT NULL CHECK (quantity > 0),
  UNIQUE(brand, model)
);
/*  */
CREATE TABLE "orders"(
  id serial PRIMARY KEY,
  "createdAt" timestamp NOT NULL DEFAULT current_timestamp,
  "userId" REFERENCES "users"(id)
);
/*  */
CREATE TABLE "users_to_orders"(
  "orderId" int REFERENCES "orders"(id),
  "userId" int REFERENCES "users"(id),
  quantity int NOT NULL,
  PRIMARY KEY ("orderId", "userId")
)
/*  Посчитать кол-во телефонов, которые были проданы  */
SELECT sum(quantity)
FROM phones_to_orders;
/*  */

SELECT sum("quantity") 
FROM "phones";

SELECT avg("price")FROM "phones";

SELECT avg("price"), "brand"
FROM "phones"
GROUP BY "brand";

SELECT sum("price"  * "quantity")
FROM "phones"
WHERE "price" BETWEEN 10000 AND 20000;

SELECT count("model"), "brand"
FROM "phones"
GROUP BY "brand";

SELECT * FROM "phones"
ORDER BY "quantity" ASC;

SELECT sum("quantity") AS "amount phones", "brand"
FROM "phones"
GROUP BY "brand"
ORDER BY "amount phones" ASC;

SELECT * FROM "users"
ORDER BY extract('year'FROM age("birthday")) ASC, "firstName" ASC;

SELECT sum("quantity"), "brand" 
FROM "phones"
GROUP BY "brand"
HAVING sum("quantity") > 80000;


SELECT char_length(concat("firstName", ' ', "lastName")) AS "fullNameLength", concat("lastName", ' ', "firstName") AS "fullName" 
FROM "users"
ORDER BY "fullName" DESC
LIMIT 1;

SELECT  char_length(concat("firstName", ' ', "lastName")) AS "length1", count(*) AS "amount"
FROM "users"
GROUP BY "length1"
HAVING char_length(concat("firstName", ' ', "lastName")) < 18;

SELECT char_length("email") AS "length", count(*)
FROM "users"
WHERE "email" LIKE 'm%'
GROUP BY "length"
HAVING char_length("email") >= 25
ORDER BY "length";

/* id заказов с айфонами*/
SELECT o.id
FROM orders AS o
  JOIN phones_to_orders AS pto ON o.id = pto."orderId"
  JOIN phones AS p ON pto."phoneId" = p.id
WHERE p.brand ILIKE 'iphone';


/* СТОИМОСТЬ КАЖДОГО ЗАКАЗА*/
SELECT o.id, o."userId", sum(p.price * pto.quantity)
FROM orders AS o
  JOIN phones_to_orders AS pto ON pto."orderId" = o.id
  JOIN phones AS p ON p.id = pto."phoneId"
GROUP BY o.id;  


/*извлечь все телефоны конкретного заказа
извлечь самый популярный телефон
извлечь пользавтелей и кол-во которые они покупали
извлечь все заказы стомостьею выше среднего чека
извлечь всех пользавтелей у которых кол-во заказов больше среднего
*/

SELECT count(p.id), p.brand 
FROM phones_to_orders AS pto
  JOIN phones AS p ON p.id = pto."phoneId"
WHERE pto."orderId" = 5  
GROUP BY p.brand; 

SELECT max(pto.quantity),o.id, sum(p.id)
FROM phones_to_orders AS pto
  JOIN orders AS o ON o.id = pto."orderId"
  JOIN phones AS p ON p.id = pto."phoneId"
GROUP BY o.id,  p.id
ORDER BY max(pto.quantity) ASC
;  


















