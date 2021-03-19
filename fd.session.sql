CREATE TABLE "users" (
  id serial PRIMARY KEY,
  first_name varchar(64) NOT NULL,
  last_name varchar(64) NOT NULL,
  email varchar(256) NOT NULL CHECK (email != ''),
  is_male boolean NOT NULL,
  birthday date NOT NULL CHECK (
    birthday < current_date
    AND birthday > '1900/1/1'
  ),
  height numeric(3, 2) NOT NULL CHECK (
    height > 0.20
    AND height < 2.5
  ),
  CONSTRAINT "CK_FULL_NAME" CHECK (
    first_name != ''
    AND last_name != ''
  )
);
ALTER TABLE "users"
ADD COLUMN "weight" int CHECK (
    "weight" BETWEEN 0 AND 300
  );
/* 
 CRUD    SQL
 
 CREATE  INSERT DML - manipulation
 READ    SELECT DQL - query
 UPDATE  UPDATE DML - manipulation
 DELETE  DELETE DML - manipulation
 */
/* */
SELECT *
FROM "users"
WHERE "id" = 600;
/*  */
UPDATE "users"
SET "weight" = 68
WHERE "id" = 600
RETURNING "weight",
  "id";
/*  */
DELETE FROM "users"
WHERE "id" = 600
RETURNING *;
/* 
 1. get all woman
 2. get all man
 3. get all adult    tip:  users age(), make_interval(), >,<, =, !=,......
 4. get all adult woman
 5. get all users: filter age > 20 and < 40
 6. get all who were born in September
 7. get all users who were born 1 November
 */
/* 1 */
SELECT *
FROM "users"
WHERE "is_male" = false;
/* 2 */
SELECT *
FROM "users"
WHERE "is_male" = true;
/* 3 */
SELECT *
FROM "users"
WHERE age("birthday") >= make_interval(18)
  AND "is_male" = false;
/* 5 */
SELECT *
FROM "users"
WHERE age("birthday") BETWEEN make_interval(20) AND make_interval(40);
/*  */
SELECT *
FROM "users"
WHERE "is_male" = false
LIMIT 10 OFFSET 0;
/*  */
SELECT "first_name" AS "Имя",
  "last_name" AS "Фамилия",
  "email" AS "Почта"
FROM "users" AS "u"
WHERE "u"."id" = 100;
/*  */
SELECT concat("first_name", ' ', "last_name") AS "Full name"
FROM "users";
/* 
 ВСЕ пользователи, полное имя которых занимает больше 15 символов.
 
 char_length
 concat
 >
 15
 */
SELECT *,
  char_length(concat("first_name", ' ', "last_name")) as "Full name"
FROM "users"
WHERE char_length(concat("first_name", ' ', "last_name")) > 20;