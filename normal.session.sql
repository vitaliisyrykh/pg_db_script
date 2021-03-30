
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

CREATE TABLE "contracts"(
  "id" serial PRIMARY KEY,
  "dateOfConclusion" timestamp NOT NULL DEFAULT current_timestamp,
  "customerId" int REFERENCES "customers"("id")
);

CREATE TABLE "orders"(
  "id" serial PRIMARY KEY,
  "contarctId" int REFERENCES "contracts"("id"),
  "productsId" int REFERENCES "contracts"("id"),
  "quantity" int NOT NULL CHECK("quantity" > 0)
);

CREATE TABLE "shipments"(
  "id" serial PRIMARY KEY,
  "shipmentTime" timestamp NOT NULL
);

CREATE TABLE "products_to_orders"(
  "id"  serial,
  "productId" int REFERENCES "products"("codeProduct"),
  PRIMARY KEY ("id", "productId")
);

CREATE TABLE "shipment_to_orders_products"(
  "id" serial ,
  "productId" int ,
  "orderId" int ,
  "quntity" int NOT NULL CHECK("quntity" > 0),
  PRIMARY KEY ("id", "productId", "orderId"),
  FOREIGN KEY ("orderId", "productId") REFERENCES "products_to_orders"
);

-- add column
ALTER TABlE tasks
ADD COLUMN deadline timestamp NOT NULL CHECK(deadline >= current_timestamp) DEFAULT current_timestamp;

--DELETE CONSTRAINT
ALTER TABlE tasks
DROP CONSTRAINT 'имя констрейнта'

ALTER TABlE tasks
ALTER COLUMN deadline DROP NOT NULL;

--ADD CONSTRAINT
ALTER TABlE tasks
ADD CONSTRAINT constraint_name CHECK (task != ' ');

--delete column 
ALTER TABlE tasks
DROP COLUMN column_name;

--change defult
ALTER TABlE tasks
ALTER COLUMN idDone DROP DEFAULT
ALTER COLUMN isDone SET DEFAULT = false;

--change type data
ALTER TABlE tasks
ALTER COLUMN task type text;

--change column_name
ALTER TABlE tasks
RENAME COLUMN task TO body;

--Change table_name
ALTER TABlE tasks
RENAME   TO users_tasks;

CREATE TABLE "users"(
  
  "login" VARCHAR(120) NOT NULL ,
  "email" varchar(300) NOT NULL ,
  "password" varchar(150) NOT NULL,
  UNIQUE("login", "email")
);

CREATE TABLE "employes"(
  "salary" int NOT NULL CHECK("salary" > 0),
  "department" varchar(100) NOT NULL ,
  "position" varchar(100) NOT NULL,
  "hireDate" timestamp NOT NULL
);

ALTER TABLE "employes"
DROP COLUMN "userId" ;

ALTER TABLE "employes"
ADD COLUMN "userId" int PRIMARY KEY REFERENCES "users"("id");

ALTER TABLE users
DROP COLUMN "password_hash";

ALTER TABLE users
ADD COLUMN "password_hash" text NOT NULL; 


INSERT INTO "users" (login, email, id, password_hash)
VALUES (
    'login:character varying',
    'email:character varying',
    1,
    'password_hash:text'
  ), (
    'login2:character varying',
    'email2:character varying',
    2,
    'password_hash:text'
  ), (
    'login3:character varying',
    'email3:character varying',
    3,
    'password_hash:text'
  );

  ALTER TABLE "employes"
  DROP COLUMN "hireDate";

  INSERT INTO "employes" (
      salary,
      department,
      position,
      "userId"
    )
  VALUES (
      1000,
      'department:character varying',
      'position:character varying',
      1
    ),(
      1000,
      'department:character varying',
      'position:character varying',
      3
    ) ;


    SELECT * FROM "users" u
      JOIN "employes" e ON u."id" = e."userId";

SELECT *, COALESCE(e.salary, 0) FROM "users" u 
  JOIN "employes"  e ON u."id" != e."userId"; 

  SELECT * FROM "users" u 
  WHERE u."id" NOT IN (SELECT e."userId" FROM "employes" e);  


/* 
 WINDOW FUNCTIONS 
 */
CREATE SCHEMA wf;
/*  */
CREATE TABLE wf.employees(
  id serial PRIMARY KEY,
  "name" varchar(256) NOT NULL CHECK("name" != ''),
  salary numeric(10, 2) NOT NULL CHECK (salary >= 0),
  hire_date timestamp NOT NULL DEFAULT current_timestamp
);
/*  */
CREATE TABLE wf.departments(
  id serial PRIMARY KEY,
  "name" varchar(64) NOT NULL
);
/*  */
ALTER TABLE wf.employees
ADD COLUMN department_id int REFERENCES wf.departments;
/*  */
INSERT INTO wf.departments("name")
VALUES ('SALES'),
  ('HR'),
  ('DEVELOPMENT'),
  ('QA'),
  ('TOP MANAGEMENT');
INSERT INTO wf.employees ("name", salary, hire_date, department_id)
VALUES ('TEST TESTov', 10000, '1990-1-1', 1),
  ('John Doe', 6000, '2010-1-1', 2),
  ('Matew Doe', 3456, '2020-1-1', 2),
  ('Matew Doe1', 53462, '2020-1-1', 3),
  ('Matew Doe2', 124543, '2012-1-1', 4),
  ('Matew Doe3', 12365, '2004-1-1', 5),
  ('Matew Doe4', 1200, '2000-8-1', 5),
  ('Matew Doe5', 2535, '2010-1-1', 2),
  ('Matew Doe6', 1000, '2014-1-1', 3),
  ('Matew Doe6', 63456, '2017-6-1', 1),
  ('Matew Doe7', 1000, '2020-1-1', 3),
  ('Matew Doe8', 346434, '2015-4-1', 2),
  ('Matew Doe9', 3421, '2018-1-1', 3),
  ('Matew Doe0', 34563, '2013-2-1', 5),
  ('Matew Doe10', 2466, '2011-1-1', 1),
  ('Matew Doe11', 9999, '1999-1-1', 5),
  ('TESTing 1', 1000, '2019-1-1', 2);
/*  */
SELECT d.name,
  count(e.id)
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
GROUP BY d.id;
/*  */
SELECT e.*,
  d.name
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
  /*  */
SELECT avg(e.salary),
  d.id
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
GROUP BY d.id;
/* JOIN
 user|dep|avg dep salary
 
 */
SELECT e.*,
  d.name,
  "d_a_s"."avg_salary"
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
  JOIN (
    SELECT avg(e.salary) AS "avg_salary",
      d.id
    FROM wf.departments d
      JOIN wf.employees e ON e.department_id = d.id
    GROUP BY d.id
  ) AS "d_a_s" ON d.id = d_a_s.id;
  /* WINDOW FUNC 
   user|dep|avg dep salary
   */
SELECT e.*,
  d.name,
  round(avg(e.salary) OVER (PARTITION BY d.id)) as "avg_dep_salary",
  sum(e.salary) OVER ()
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id;

SELECT d."name", sum(e.salary) OVER ()
FROM wf.departments d
  JOIN employees e ON e.depaetment_id = d.id
GROUP BY d.id;