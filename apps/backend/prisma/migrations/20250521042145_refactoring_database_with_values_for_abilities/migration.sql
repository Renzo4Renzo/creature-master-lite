/*
  Warnings:

  - You are about to drop the column `dynamicQty` on the `AbilityAction` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Ability" ADD COLUMN     "value" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "AbilityAction" DROP COLUMN "dynamicQty";
