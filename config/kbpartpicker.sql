-- -------------------------------------------------------------
-- TablePlus 3.12.2(358)
--
-- https://tableplus.com/
--
-- Database: kbpartpicker
-- Generation Time: 2021-01-30 20:45:49.9880
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS country_id_seq;

-- Table Definition
CREATE TABLE "public"."countries" (
    "id" int4 NOT NULL DEFAULT nextval('country_id_seq'::regclass),
    "country_name" varchar NOT NULL,
    "country_code" varchar,
    "iso_code" varchar,
    "currency_code" varchar,
    "exchange_rate" float8 NOT NULL,
    "created_at" timestamp,
    "updated_at" timestamp,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS switches_id_seq;
DROP TYPE IF EXISTS "public"."stabilizer_type";
CREATE TYPE "public"."stabilizer_type" AS ENUM ('pcb_screw_in', 'pcb_snap_in', 'plate_mount');
DROP TYPE IF EXISTS "public"."product_type";
CREATE TYPE "public"."product_type" AS ENUM ('switch', 'case', 'pcb', 'plate', 'keyset', 'kit', 'stabilizer', 'lube', 'film', 'spring', 'tool', 'deskmat');
DROP TYPE IF EXISTS "public"."keyboard_profile";
CREATE TYPE "public"."keyboard_profile" AS ENUM ('frowless', 'forty_percent', 'sixty_percent', 'sixtyfive_percent', 'seventyfive_percent', 'tenkeyless', 'winkeyless', 'hhkb', 'full_size');
DROP TYPE IF EXISTS "public"."stabilizer_size";
CREATE TYPE "public"."stabilizer_size" AS ENUM ('six_point_25_u', 'seven_u', 'two_u');
DROP TYPE IF EXISTS "public"."switch_profile";
CREATE TYPE "public"."switch_profile" AS ENUM ('medium', 'low', 'high');
DROP TYPE IF EXISTS "public"."switch_type";
CREATE TYPE "public"."switch_type" AS ENUM ('linear', 'tactile', 'clicky');
DROP TYPE IF EXISTS "public"."keyboard_layout";
CREATE TYPE "public"."keyboard_layout" AS ENUM ('iso', 'ansi');

-- Table Definition
CREATE TABLE "public"."products" (
    "id" int4 NOT NULL DEFAULT nextval('switches_id_seq'::regclass),
    "name" varchar NOT NULL,
    "img_url" varchar,
    "hotswap" bool,
    "created_at" timestamp,
    "updated_at" timestamp,
    "stabilizer_type" "public"."stabilizer_type",
    "product_type" "public"."product_type",
    "keyboard_profile" "public"."keyboard_profile",
    "stabilizer_size" "public"."stabilizer_size",
    "switch_profile" "public"."switch_profile",
    "switch_type" "public"."switch_type",
    "keyboard_layout" "public"."keyboard_layout",
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS vendor_product_association_id_seq;

-- Table Definition
CREATE TABLE "public"."vendor_product_associations" (
    "id" int4 NOT NULL DEFAULT nextval('vendor_product_association_id_seq'::regclass),
    "product_id" int4 NOT NULL,
    "vendor_id" int4 NOT NULL,
    "in_stock" bool,
    "price" float8,
    "url" varchar,
    "created_at" timestamp,
    "updated_at" timestamp,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS vendors_id_seq;

-- Table Definition
CREATE TABLE "public"."vendors" (
    "id" int4 NOT NULL DEFAULT nextval('vendors_id_seq'::regclass),
    "name" varchar NOT NULL,
    "url" varchar NOT NULL,
    "created_at" timestamp,
    "updated_at" timestamp,
    "country_id" int4,
    PRIMARY KEY ("id")
);

ALTER TABLE "public"."vendor_product_associations" ADD FOREIGN KEY ("vendor_id") REFERENCES "public"."vendors"("id");
ALTER TABLE "public"."vendor_product_associations" ADD FOREIGN KEY ("product_id") REFERENCES "public"."products"("id");
ALTER TABLE "public"."vendor_product_associations" ADD FOREIGN KEY ("product_id") REFERENCES "public"."products"("id");
ALTER TABLE "public"."vendor_product_associations" ADD FOREIGN KEY ("vendor_id") REFERENCES "public"."vendors"("id");
ALTER TABLE "public"."vendors" ADD FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id");
ALTER TABLE "public"."vendors" ADD FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id");