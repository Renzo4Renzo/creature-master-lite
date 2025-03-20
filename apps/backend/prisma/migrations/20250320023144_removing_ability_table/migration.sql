/*
  Warnings:

  - You are about to drop the column `abilityId` on the `CreatureAbility` table. All the data in the column will be lost.
  - You are about to drop the column `abilityId` on the `HeroAbility` table. All the data in the column will be lost.
  - You are about to drop the `Ability` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `AbilityAction` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `description` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `target` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `trigger` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `HeroAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `HeroAbility` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "AbilityAction" DROP CONSTRAINT "AbilityAction_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "CreatureAbility" DROP CONSTRAINT "CreatureAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "HeroAbility" DROP CONSTRAINT "HeroAbility_abilityId_fkey";

-- DropIndex
DROP INDEX "CreatureAbility_creatureId_abilityId_key";

-- AlterTable
ALTER TABLE "CreatureAbility" DROP COLUMN "abilityId",
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "singleUse" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "target" TEXT NOT NULL,
ADD COLUMN     "trigger" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "HeroAbility" DROP COLUMN "abilityId",
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL;

-- DropTable
DROP TABLE "Ability";

-- DropTable
DROP TABLE "AbilityAction";

-- CreateTable
CREATE TABLE "CreatureAbilityAction" (
    "id" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "dynamicQty" BOOLEAN NOT NULL,

    CONSTRAINT "CreatureAbilityAction_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CreatureAbilityAction" ADD CONSTRAINT "CreatureAbilityAction_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "CreatureAbility"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "CreatureAbility"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
