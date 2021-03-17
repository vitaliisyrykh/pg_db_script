DROP TABLE "users";
CREATE TABLE "users" (
  first_name varchar(64) NOT NULL CHECK (first_name != ''),
  last_name varchar(64) NOT NULL CHECK (last_name != ''),
  email varchar(256) NOT NULL UNIQUE CHECK (email != ''),
  is_male boolean NOT NULL,
  birthday date NOT NULL CHECK (birthday < current_date),
  height numeric(3, 2) NOT NULL CHECK (
    height > 0.20
    AND height < 2.5
  )
);
INSERT INTO "users"
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


/* 

  Отношение
  Атрибуты
  Домен
  Кортеж

  CREATE DATABASE "test";

  SQL: 
        TCL  - transaction
        DDL  - CREATE
        DML  - DELETE, INSERT, UPDATE
        DQL  - SELECT
        DCL  - GRANT, REVOKE
 */

