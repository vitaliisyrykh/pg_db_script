DROP TABLE "users";
/*  */
CREATE TABLE "users" (
  id serial PRIMARY KEY,
  first_name varchar(64) NOT NULL,
  last_name varchar(64) NOT NULL,
  email varchar(256) NOT NULL,
  is_male boolean NOT NULL,
  birthday date NOT NULL CHECK (
    birthday < current_date
    AND birthday > '1900/1/1'
  ),
  height numeric(3, 2) NOT NULL CHECK (
    height > 0.20
    AND height < 2.5
  ),
  UNIQUE(first_name, last_name),
  CONSTRAINT "CK_EMAIL_NOT_EMPTY" CHECK (email != ''),
  CONSTRAINT "CK_FULL_NAME" CHECK (
    first_name != ''
    AND last_name != ''
  )
);
/*  */
INSERT INTO "users" (
    "first_name",
    "last_name",
    "email",
    "is_male",
    "birthday",
    "height"
  )
VALUES (
    'Test',
    'Testovich1',
    'test1@mail.com',
    true,
    '1999-1-25',
    0.6
  ),
  (
    'Test',
    'Testovich2',
    'hahahaha',
    true,
    '1900-11-11',
    0.60
  ),
  (
    'Test',
    '123',
    'test2@mail.com',
    true,
    '1999-1-25',
    1.90
  ),
  (
    '123',
    'Testovich4',
    'test3@mail.com',
    true,
    '1999-1-25',
    1.90
  );
CREATE TABLE "products"(
  "id" serial PRIMARY KEY,
  "name" varchar(256),
  "category" varchar(128),
  "price" decimal(16, 2) CHECK ("price" > 0),
  "quantity" int CHECK("quantity" > 0),
  UNIQUE("name", "category")
);
/* 
 МНОГИЕ КО МНОГИМ
 С ПОМОЩЬЮ СВЯЗУЮЩЕЙ ТАБЛИЦЫ
 СОСТАВНОЙ ПЕРВИЧНЫЙ КЛЮЧ
 */
CREATE TABLE "products_to_orders"(
  product_id integer,
  order_id integer,
  quantity integer,
  PRIMARY KEY (product_id, order_id)
);

INSERT INTO "products_to_orders" ("product_id", "order_id", "quantity")
VALUES (1,1,2),
(3,1,1),
(2,1,5);

/*  */
INSERT INTO "products" ("name", "category", "price", "quantity")
VALUES ('sony xl', 'phone', 10000, 10000),
  ('samsung XX', 'phone', 20000, 200),
  ('acer', 'laptop', 30000, 20),
  ('lenovo', 'laptop', 30000, 2000);
/* СВЯЗЬ ОДИН к ОДНОМУ. REFERENCES */
DROP TABLE "orders";
CREATE TABLE "orders"(
  "id" serial PRIMARY KEY,
  "customer_id" int REFERENCES "users" ("id"),
  "created_at" timestamp NOT NULL DEFAULT current_timestamp
);
INSERT INTO "orders" ("customer_id")
VALUES(1);