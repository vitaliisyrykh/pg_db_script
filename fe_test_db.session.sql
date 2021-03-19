ALTER TABLE "users"
ADD COLUMN "weight" int CHECK(
    "weight" BETWEEN 0 AND 500
  );
/*
 CRUD      SQL
 
 READ      SELECT  -  query
 
 CREATE    INSERT  -  manipulation
 UPDATE    UPDATE  -  manipulation
 DELETE    DELETE  -  manipulation
 */
SELECT *
FROM "users"
WHERE "is_male" = false;
/*  ВСЕ ЮЗЕРЫ, С ЧЕТНЫМИ ID  */
SELECT *
FROM "users"
WHERE "id" % 2 = 0;
/* ВСЕ ЮЗЕРЫ МУЖСКОГО ПОЛА С НЕЧЁТНЫМ ID  */
SELECT *
FROM "users"
WHERE "id" % 2 = 1
  AND "is_male" = true;
/*  */
UPDATE "users"
SET "weight" = 400
WHERE "id" = 2006
RETURNING "id",
  "weight",
  "email";
/*  */
DELETE FROM "users"
WHERE "id" = 2200
RETURNING *;
/* 
 1. get all man
 2. get all woman
 3. get all adult users        tip: 9 chapter
 4. get all adult woman
 5. get all users age > 20 & age < 40
 6. get all users with age > 20 & height > 1.8
 7. get all users: were born September
 8. get all users: born 1 November
 9. delete all <30 y
 */
SELECT *
FROM "users"
WHERE age("birthday") > make_interval(40)
  AND "is_male" = false;
/*  */
SELECT *
FROM "users"
WHERE age("birthday") BETWEEN make_interval(20) AND make_interval(40);
/*  */
SELECT *
FROM "users"
WHERE extract (
    'month'
    from "birthday"
  ) = 9;
/* */
SELECT "id" AS "Порядковый номер",
  "first_name" AS "Имя",
  "last_name" AS "Фамилия",
  "email" AS "Почта"
FROM "users" AS "u"
WHERE "u"."id" = 2890;
/* PAGINATION */
SELECT *
FROM "users"
LIMIT 15 OFFSET 45;
/*  */
SELECT "id",
  concat("first_name", ' ', "last_name") AS "Full name",
  "email"
FROM "users"
LIMIT 10;
/* Получить всех пользователей с длинной полного имени больше 15 символов  */
SELECT "id",
  concat("first_name", ' ', "last_name") AS "Full name",
  "email"
FROM "users"
WHERE char_length(concat("first_name", ' ', "last_name")) > 15
LIMIT 10;
/*  */
SELECT *
FROM (
    SELECT "id",
      concat("first_name", ' ', "last_name") AS "Full name",
      "email"
    FROM "users"
  ) AS "FN"
WHERE char_length("FN"."Full name") > 20;
/*  */