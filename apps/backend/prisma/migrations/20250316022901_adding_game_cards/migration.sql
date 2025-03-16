/*
  Warnings:

  - You are about to drop the column `cardId` on the `Ability` table. All the data in the column will be lost.
  - You are about to drop the column `effectType` on the `Ability` table. All the data in the column will be lost.
  - You are about to drop the column `effectValue` on the `Ability` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `Ability` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "Ability" DROP CONSTRAINT "Ability_cardId_fkey";

-- AlterTable
ALTER TABLE "Ability" DROP COLUMN "cardId",
DROP COLUMN "effectType",
DROP COLUMN "effectValue";

-- CreateTable
CREATE TABLE "CreatureAbility" (
    "id" TEXT NOT NULL,
    "creatureId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,

    CONSTRAINT "CreatureAbility_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameCard" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "health" INTEGER NOT NULL,

    CONSTRAINT "GameCard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameCardAbility" (
    "id" TEXT NOT NULL,
    "gameCardId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "GameCardAbility_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CreatureAbility_creatureId_abilityId_key" ON "CreatureAbility"("creatureId", "abilityId");

-- CreateIndex
CREATE UNIQUE INDEX "Ability_name_key" ON "Ability"("name");

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCard" ADD CONSTRAINT "GameCard_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "LiveGame"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCard" ADD CONSTRAINT "GameCard_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCard" ADD CONSTRAINT "GameCard_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_gameCardId_fkey" FOREIGN KEY ("gameCardId") REFERENCES "GameCard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
