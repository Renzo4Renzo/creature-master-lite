/*
  Warnings:

  - You are about to drop the column `trigger` on the `Ability` table. All the data in the column will be lost.
  - You are about to drop the column `abilityId` on the `AbilityAction` table. All the data in the column will be lost.
  - You are about to drop the column `action` on the `TurnPhase` table. All the data in the column will be lost.
  - You are about to drop the column `target` on the `TurnPhase` table. All the data in the column will be lost.
  - Added the required column `creatureAbilityId` to the `AbilityAction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetLocation` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetOwner` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetType` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `trigger` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "AbilityAction" DROP CONSTRAINT "AbilityAction_abilityId_fkey";

-- AlterTable
ALTER TABLE "Ability" DROP COLUMN "trigger";

-- AlterTable
ALTER TABLE "AbilityAction" DROP COLUMN "abilityId",
ADD COLUMN     "creatureAbilityId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "CreatureAbility" ADD COLUMN     "singleUse" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "targetLocation" TEXT NOT NULL,
ADD COLUMN     "targetOwner" TEXT NOT NULL,
ADD COLUMN     "targetType" TEXT NOT NULL,
ADD COLUMN     "trigger" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "TurnPhase" DROP COLUMN "action",
DROP COLUMN "target";

-- AddForeignKey
ALTER TABLE "AbilityAction" ADD CONSTRAINT "AbilityAction_creatureAbilityId_fkey" FOREIGN KEY ("creatureAbilityId") REFERENCES "CreatureAbility"("id") ON DELETE CASCADE ON UPDATE CASCADE;
