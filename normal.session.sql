
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