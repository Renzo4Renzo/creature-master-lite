/*
  Warnings:

  - You are about to drop the `_CreatureAbilities` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CreatureAbilities" DROP CONSTRAINT "_CreatureAbilities_A_fkey";

-- DropForeignKey
ALTER TABLE "_CreatureAbilities" DROP CONSTRAINT "_CreatureAbilities_B_fkey";

-- DropTable
DROP TABLE "_CreatureAbilities";

-- CreateTable
CREATE TABLE "CreatureAbility" (
    "creatureId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,

    CONSTRAINT "CreatureAbility_pkey" PRIMARY KEY ("creatureId","abilityId")
);

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
