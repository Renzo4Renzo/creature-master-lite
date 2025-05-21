/*
  Warnings:

  - You are about to drop the column `creatureAbilityId` on the `AbilityAction` table. All the data in the column will be lost.
  - You are about to drop the column `heroInGameId` on the `AbilityInGame` table. All the data in the column will be lost.
  - You are about to drop the `CreatureAbility` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HeroAbility` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `creatureId` to the `Ability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetLocation` to the `Ability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetOwner` to the `Ability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetType` to the `Ability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `trigger` to the `Ability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `abilityId` to the `AbilityAction` table without a default value. This is not possible if the table is not empty.
  - Made the column `creatureInGameId` on table `AbilityInGame` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "AbilityAction" DROP CONSTRAINT "AbilityAction_creatureAbilityId_fkey";

-- DropForeignKey
ALTER TABLE "AbilityInGame" DROP CONSTRAINT "AbilityInGame_creatureInGameId_fkey";

-- DropForeignKey
ALTER TABLE "AbilityInGame" DROP CONSTRAINT "AbilityInGame_heroInGameId_fkey";

-- DropForeignKey
ALTER TABLE "CreatureAbility" DROP CONSTRAINT "CreatureAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "CreatureAbility" DROP CONSTRAINT "CreatureAbility_creatureId_fkey";

-- DropForeignKey
ALTER TABLE "HeroAbility" DROP CONSTRAINT "HeroAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "HeroAbility" DROP CONSTRAINT "HeroAbility_heroId_fkey";

-- AlterTable
ALTER TABLE "Ability" ADD COLUMN     "creatureId" TEXT NOT NULL,
ADD COLUMN     "singleUse" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "targetLocation" "TargetLocation" NOT NULL,
ADD COLUMN     "targetOwner" "TargetOwner" NOT NULL,
ADD COLUMN     "targetType" "TargetType" NOT NULL,
ADD COLUMN     "trigger" "AbilityTrigger" NOT NULL;

-- AlterTable
ALTER TABLE "AbilityAction" DROP COLUMN "creatureAbilityId",
ADD COLUMN     "abilityId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "AbilityInGame" DROP COLUMN "heroInGameId",
ADD COLUMN     "grantedByHero" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "creatureInGameId" SET NOT NULL;

-- DropTable
DROP TABLE "CreatureAbility";

-- DropTable
DROP TABLE "HeroAbility";

-- CreateTable
CREATE TABLE "HeroAbilityOption" (
    "id" TEXT NOT NULL,
    "heroId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,
    "cost" INTEGER NOT NULL,

    CONSTRAINT "HeroAbilityOption_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Ability" ADD CONSTRAINT "Ability_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityAction" ADD CONSTRAINT "AbilityAction_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroAbilityOption" ADD CONSTRAINT "HeroAbilityOption_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroAbilityOption" ADD CONSTRAINT "HeroAbilityOption_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityInGame" ADD CONSTRAINT "AbilityInGame_creatureInGameId_fkey" FOREIGN KEY ("creatureInGameId") REFERENCES "CreatureInGame"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
