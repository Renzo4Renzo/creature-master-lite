/*
  Warnings:

  - The primary key for the `HeroAbility` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `HeroAbility` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "HeroAbility" DROP CONSTRAINT "HeroAbility_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "HeroAbility_pkey" PRIMARY KEY ("heroId", "abilityId");
