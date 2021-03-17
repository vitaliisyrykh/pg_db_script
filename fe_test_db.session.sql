DROP TABLE "users";
/*  */
CREATE TABLE "users" (
  id serial PRIMARY KEY,
  first_name varchar(64) NOT NULL CHECK (first_name != ''),
  last_name varchar(64) NOT NULL CHECK (last_name != ''),
  email varchar(256) NOT NULL UNIQUE,
  is_male boolean NOT NULL,
  birthday date NOT NULL CHECK (birthday < current_date),
  height numeric(3, 2) NOT NULL CHECK (
    height > 0.20
    AND height < 2.5
  ),
  CONSTRAINT "CK_EMAIL_NOT_EMPTY" CHECK (email != '')
);






/* Запретить повторение пар b, c */

DROP TABLE A;

CREATE TABLE A(
  b int,
  c int,
  CONSTRAINT "UNIQUE_PAIR" PRIMARY KEY(b, c)
);

INSERT INTO A
VALUES (1, 1),
  (2, 1);










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
    'Testovich',
    'test1@mail.com',
    true,
    '1999-1-25',
    0.5
  ),
  (
    'Test',
    'Testovich',
    'hahahaha',
    true,
    '1000-11-11',
    0.30
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
    'Testovich',
    'test3@mail.com',
    true,
    '1999-1-25',
    1.90
  );
/*  */
DROP TABLE "messages";
/*  */
CREATE TABLE "messages"(
  "id" bigserial PRIMARY KEY,
  "body" varchar(5000) NOT NULL CHECK("body" != ''),
  "author" varchar(256) NOT NULL CHECK("author" != ''),
  "createdAt" timestamp NOT NULL DEFAULT current_timestamp,
  "isRead" boolean NOT NULL DEFAULT false
);
/*  */
INSERT INTO "messages" ("author", "body")
VALUES ('Test Testovich', 'test text'),
  ('Test Testovich', 'test text'),
  ('Test Testovich', 'test text');