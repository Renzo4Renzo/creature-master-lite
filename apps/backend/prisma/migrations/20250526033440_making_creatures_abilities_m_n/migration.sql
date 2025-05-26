/*
  Warnings:

  - You are about to drop the column `creatureId` on the `Ability` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Ability" DROP CONSTRAINT "Ability_creatureId_fkey";

-- AlterTable
ALTER TABLE "Ability" DROP COLUMN "creatureId";

-- CreateTable
CREATE TABLE "_CreatureAbilities" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_CreatureAbilities_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_CreatureAbilities_B_index" ON "_CreatureAbilities"("B");

-- AddForeignKey
ALTER TABLE "_CreatureAbilities" ADD CONSTRAINT "_CreatureAbilities_A_fkey" FOREIGN KEY ("A") REFERENCES "Ability"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CreatureAbilities" ADD CONSTRAINT "_CreatureAbilities_B_fkey" FOREIGN KEY ("B") REFERENCES "Creature"("id") ON DELETE CASCADE ON UPDATE CASCADE;
