-- CreateEnum
CREATE TYPE "Role" AS ENUM ('OWNER', 'SUPERVISOR', 'MANAGER', 'STAFF');

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL DEFAULT '',
    "email" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "password" TEXT NOT NULL DEFAULT '',
    "refresh_token" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_login" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "company_name" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee" (
    "id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "face_img" TEXT NOT NULL DEFAULT '',
    "nrc_front_img" TEXT NOT NULL DEFAULT '',
    "nrc_back_img" TEXT NOT NULL DEFAULT '',
    "contract_img" TEXT NOT NULL DEFAULT '',
    "phone_number" TEXT NOT NULL DEFAULT '',
    "email" TEXT NOT NULL DEFAULT '',
    "passcode" TEXT NOT NULL DEFAULT '',
    "role" "Role" NOT NULL,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "item" (
    "id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "image_url" TEXT DEFAULT '',
    "item_name" TEXT NOT NULL DEFAULT '',
    "one_item_price" INTEGER NOT NULL DEFAULT 0,
    "one_pack_price" INTEGER NOT NULL DEFAULT 0,
    "one_carton_price" INTEGER NOT NULL DEFAULT 0,
    "buying_price_by_item" INTEGER NOT NULL DEFAULT 0,
    "having_items_qty" INTEGER NOT NULL DEFAULT 0,
    "having_packing_qty" INTEGER NOT NULL DEFAULT 0,
    "having_carton_qty" INTEGER NOT NULL DEFAULT 0,
    "expire_at" TIMESTAMP(3) NOT NULL,
    "item_barcode" TEXT NOT NULL DEFAULT '',
    "packing_barcode" TEXT DEFAULT '',
    "carton_barcode" TEXT DEFAULT '',
    "items_price_by_product_qty" JSONB,
    "packing_price_by_product_qty" JSONB,
    "carton_price_by_product_qty" JSONB,
    "categorie_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "item_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_phone_number_key" ON "user"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "employee_name_key" ON "employee"("name");

-- AddForeignKey
ALTER TABLE "company" ADD CONSTRAINT "company_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item" ADD CONSTRAINT "item_categorie_id_fkey" FOREIGN KEY ("categorie_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
