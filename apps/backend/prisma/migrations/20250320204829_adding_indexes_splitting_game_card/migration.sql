/*
  Warnings:

  - You are about to drop the column `description` on the `CreatureAbility` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `CreatureAbility` table. All the data in the column will be lost.
  - You are about to drop the column `singleUse` on the `CreatureAbility` table. All the data in the column will be lost.
  - You are about to drop the column `target` on the `CreatureAbility` table. All the data in the column will be lost.
  - You are about to drop the column `trigger` on the `CreatureAbility` table. All the data in the column will be lost.
  - You are about to drop the column `gameCardId` on the `GameCardAbility` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `HeroAbility` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `HeroAbility` table. All the data in the column will be lost.
  - You are about to drop the `CreatureAbilityAction` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `GameCard` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[creatureId,abilityId]` on the table `CreatureAbility` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `abilityId` to the `CreatureAbility` table without a default value. This is not possible if the table is not empty.
  - Added the required column `abilityId` to the `HeroAbility` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CreatureAbilityAction" DROP CONSTRAINT "CreatureAbilityAction_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "GameCard" DROP CONSTRAINT "GameCard_creatureId_fkey";

-- DropForeignKey
ALTER TABLE "GameCard" DROP CONSTRAINT "GameCard_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameCard" DROP CONSTRAINT "GameCard_heroId_fkey";

-- DropForeignKey
ALTER TABLE "GameCard" DROP CONSTRAINT "GameCard_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_gameCardId_fkey";

-- AlterTable
ALTER TABLE "CreatureAbility" DROP COLUMN "description",
DROP COLUMN "name",
DROP COLUMN "singleUse",
DROP COLUMN "target",
DROP COLUMN "trigger",
ADD COLUMN     "abilityId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "GameCardAbility" DROP COLUMN "gameCardId",
ADD COLUMN     "gameCreatureId" TEXT,
ADD COLUMN     "gameHeroId" TEXT;

-- AlterTable
ALTER TABLE "HeroAbility" DROP COLUMN "description",
DROP COLUMN "name",
ADD COLUMN     "abilityId" TEXT NOT NULL;

-- DropTable
DROP TABLE "CreatureAbilityAction";

-- DropTable
DROP TABLE "GameCard";

-- CreateTable
CREATE TABLE "Ability" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "trigger" TEXT NOT NULL,

    CONSTRAINT "Ability_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AbilityAction" (
    "id" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "dynamicQty" BOOLEAN NOT NULL,

    CONSTRAINT "AbilityAction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameCreature" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "creatureId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "health" INTEGER NOT NULL,
    "energy" INTEGER,

    CONSTRAINT "GameCreature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameHero" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "heroId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "energy" INTEGER NOT NULL,

    CONSTRAINT "GameHero_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Ability_name_key" ON "Ability"("name");

-- CreateIndex
CREATE UNIQUE INDEX "GameHero_heroId_key" ON "GameHero"("heroId");

-- CreateIndex
CREATE UNIQUE INDEX "CreatureAbility_creatureId_abilityId_key" ON "CreatureAbility"("creatureId", "abilityId");

-- CreateIndex
CREATE INDEX "LiveGame_player1Id_player2Id_idx" ON "LiveGame"("player1Id", "player2Id");

-- CreateIndex
CREATE INDEX "MatchmakingQueue_createdAt_idx" ON "MatchmakingQueue"("createdAt");

-- CreateIndex
CREATE INDEX "Turn_gameId_playerId_idx" ON "Turn"("gameId", "playerId");

-- CreateIndex
CREATE INDEX "TurnPhase_turnId_playerId_idx" ON "TurnPhase"("turnId", "playerId");

-- AddForeignKey
ALTER TABLE "AbilityAction" ADD CONSTRAINT "AbilityAction_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroAbility" ADD CONSTRAINT "HeroAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCreature" ADD CONSTRAINT "GameCreature_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "LiveGame"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCreature" ADD CONSTRAINT "GameCreature_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCreature" ADD CONSTRAINT "GameCreature_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameHero" ADD CONSTRAINT "GameHero_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "LiveGame"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameHero" ADD CONSTRAINT "GameHero_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameHero" ADD CONSTRAINT "GameHero_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_gameCreatureId_fkey" FOREIGN KEY ("gameCreatureId") REFERENCES "GameCreature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_gameHeroId_fkey" FOREIGN KEY ("gameHeroId") REFERENCES "GameHero"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
