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

SELECT  count(p.id), p.brand  
FROM phones_to_orders AS pto
 JOIN phones AS p ON p.id = pto."phoneId"
WHERE pto."orderId" = 5  
 GROUP BY p.brand ; 

SELECT max(pto.quantity),o.id, sum(p.id)
FROM phones_to_orders AS pto
  JOIN orders AS o ON o.id = pto."orderId"
  JOIN phones AS p ON p.id = pto."phoneId"
GROUP BY o.id,  p.id
ORDER BY max(pto.quantity) ASC
;

/*кол-во заказов каждого пользвателей*/
SELECT u.id, u.email, count(o.id)
FROM users AS u
  JOIN orders AS o ON u.id = o."userId"
GROUP BY u.id
ORDER BY u.id; 

/*кол-во позиций товара в определённом заказе*/

SELECT count(pto."phoneId"), o.id
FROM phones_to_orders AS pto
  JOIN orders AS o ON pto."orderId" = o.id
WHERE o.id = 1
GROUP BY o.id;

/*извлечь самый популярный телефон*/

SELECT p.brand, sum(pto.quantity)
FROM phones AS p
  JOIN phones_to_orders AS pto ON pto."phoneId" = p.id
GROUP BY p.brand
ORDER BY sum(pto.quantity) DESC
LIMIT 1 ;


/*извлечь пользавтелей и кол-во моделей, которые они покупали*/
SELECT "uid_with_pid"."userId", count("uid_with_pid"."phoneId")
FROM(
  SELECT  u.id,u."firstName",count(pto."phoneId")
  FROM users AS u
    JOIN orders AS o ON o."userId" = u.id
    JOIN phones_to_orders AS pto ON o.id = pto."orderId"
    JOIN phones p ON p.id = pto."phoneId"
  GROUP BY u.id
)  AS "uid_with_pid"
GROUP BY "uid_with_pid"."userId"

/*извлечь всех пользавателем у которых кол-во заказов больше среднего*/

WITH count_orders AS (SELECT u.id,count(o.id) AS "count", u.email 
FROM "users" u
  JOIN "orders" o ON u.id = o."userId"
GROUP BY u.id)

SELECT *
FROM count_orders AS co
WHERE co."count" > (
  SELECT avg(co."count")
  FROM count_orders AS co
);
DROP TABLE "tasks";
CREATE TABLE "tasks"(
  "id" serial PRIMARY KEY,
  "heading" varchar(60) NOT NULL,
  "userId" int REFERENCES "users"("id"),
  "isDone" boolean NOT NULL,
  "createdAt" timestamp NOT NULL DEFAULT current_timestamp,
  "body" varchar(300) NOT NULL 
);

INSERT INTO "tasks"("heading", "body","userId","isDone")
VALUES ('some heading', 'some text body',4,false),
('some heading 2', 'some text body2',5,true),
('some heading 3', 'some text body3',12,false),
('some heading 4', 'some text body4', 4, true),
('some heading5', 'some text body5', 5, true);

SELECT u."id", count("isDone"), t."isDone"
FROM "users" AS u
  JOIN "tasks" AS t ON t."userId" = u."id"
WHERE t."isDone" = true
GROUP BY u."id", t."isDone";



CREATE TABLE "products"(
  "codeProduct" int PRIMARY KEY,
  "nameProduct" varchar(120) NOT NULL UNIQUE,
  "price" int NOT NULL CHECK("price" > 0)
);

CREATE TABLE "customers" (
  "id" serial PRIMARY KEY,
  "nameCustomer" varchar(120) NOT NULL ,
  "adress" jsonb,
  "phoneNumber" varchar(11) NOT NULL,
  UNIQUE ("adress", "phoneNumber", "nameCustomer")
);

CREATE TABLE "customer_to_contracts"(
  "id" serial PRIMARY KEY,
  "customerId" int REFERENCES "customers"("id"),
  "contractId" int REFERENCES "contracts"("id"),
);

CREATE TABLE "contracts"(
  "id" serial PRIMARY KEY,
  "dateOfConclusion" timestamp NOT NULL DEFAULT current_timestamp,
);

CREATE TABLE "orders"(
  ""
)
























