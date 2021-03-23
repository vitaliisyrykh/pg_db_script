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

