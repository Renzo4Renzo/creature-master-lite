/*
  Warnings:

  - You are about to drop the column `temperament` on the `Creature` table. All the data in the column will be lost.
  - You are about to drop the column `conditions` on the `Hero` table. All the data in the column will be lost.
  - You are about to drop the `CompletedMatch` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `GameCardAbility` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `GameCreature` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `GameHero` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `LiveGame` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `quality` to the `Ability` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `action` on the `AbilityAction` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `storage` to the `Creature` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `targetLocation` on the `CreatureAbility` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `targetOwner` on the `CreatureAbility` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `targetType` on the `CreatureAbility` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `trigger` on the `CreatureAbility` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "AbilityQuality" AS ENUM ('REGULAR', 'BEST');

-- CreateEnum
CREATE TYPE "AbilityTrigger" AS ENUM ('RECRUITMENT_ASSIGNMENT', 'ROLLING_DICE', 'ENTERING_BATTLE', 'WINNING_BATTLE', 'DYING_IN_BATTLE');

-- CreateEnum
CREATE TYPE "TargetType" AS ENUM ('CREATURE', 'HERO');

-- CreateEnum
CREATE TYPE "TargetOwner" AS ENUM ('ONESELF', 'ENEMY');

-- CreateEnum
CREATE TYPE "TargetLocation" AS ENUM ('CURRENT_ALLY', 'CURRENT_ENEMY', 'ENEMY_FIELD', 'OWN_HERO_ZONE', 'ENEMY_HERO_ZONE');

-- CreateEnum
CREATE TYPE "AbilityActionType" AS ENUM ('HEALTH_UPDATE', 'STORAGE_UPDATE', 'DICE_UPDATE', 'ASK_IF_REROLL', 'DICE_REROLL', 'ENERGY_UPDATE', 'NO_BATTLE_DAMAGE', 'DISCARD', 'CANT_MOVE', 'RETURN_TO_HAND');

-- DropForeignKey
ALTER TABLE "CompletedMatch" DROP CONSTRAINT "CompletedMatch_player1Id_fkey";

-- DropForeignKey
ALTER TABLE "CompletedMatch" DROP CONSTRAINT "CompletedMatch_player2Id_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_gameCreatureId_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_gameHeroId_fkey";

-- DropForeignKey
ALTER TABLE "GameCreature" DROP CONSTRAINT "GameCreature_creatureId_fkey";

-- DropForeignKey
ALTER TABLE "GameCreature" DROP CONSTRAINT "GameCreature_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameCreature" DROP CONSTRAINT "GameCreature_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "GameHero" DROP CONSTRAINT "GameHero_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameHero" DROP CONSTRAINT "GameHero_heroId_fkey";

-- DropForeignKey
ALTER TABLE "GameHero" DROP CONSTRAINT "GameHero_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "LiveGame" DROP CONSTRAINT "LiveGame_player1Id_fkey";

-- DropForeignKey
ALTER TABLE "LiveGame" DROP CONSTRAINT "LiveGame_player2Id_fkey";

-- DropForeignKey
ALTER TABLE "Turn" DROP CONSTRAINT "Turn_gameId_fkey";

-- DropIndex
DROP INDEX "Turn_gameId_playerId_idx";

-- DropIndex
DROP INDEX "TurnPhase_turnId_playerId_idx";

-- AlterTable
ALTER TABLE "Ability" ADD COLUMN     "quality" "AbilityQuality" NOT NULL,
ALTER COLUMN "description" DROP NOT NULL;

-- AlterTable
ALTER TABLE "AbilityAction" DROP COLUMN "action",
ADD COLUMN     "action" "AbilityActionType" NOT NULL;

-- AlterTable
ALTER TABLE "Creature" DROP COLUMN "temperament",
ADD COLUMN     "storage" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "CreatureAbility" DROP COLUMN "targetLocation",
ADD COLUMN     "targetLocation" "TargetLocation" NOT NULL,
DROP COLUMN "targetOwner",
ADD COLUMN     "targetOwner" "TargetOwner" NOT NULL,
DROP COLUMN "targetType",
ADD COLUMN     "targetType" "TargetType" NOT NULL,
DROP COLUMN "trigger",
ADD COLUMN     "trigger" "AbilityTrigger" NOT NULL;

-- AlterTable
ALTER TABLE "Hero" DROP COLUMN "conditions";

-- DropTable
DROP TABLE "CompletedMatch";

-- DropTable
DROP TABLE "GameCardAbility";

-- DropTable
DROP TABLE "GameCreature";

-- DropTable
DROP TABLE "GameHero";

-- DropTable
DROP TABLE "LiveGame";

-- CreateTable
CREATE TABLE "AbilityInGame" (
    "id" TEXT NOT NULL,
    "creatureInGameId" TEXT,
    "heroInGameId" TEXT,
    "abilityId" TEXT NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AbilityInGame_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Game" (
    "id" TEXT NOT NULL,
    "player1Id" TEXT NOT NULL,
    "player2Id" TEXT NOT NULL,
    "currentTurn" INTEGER NOT NULL DEFAULT 1,
    "status" TEXT NOT NULL DEFAULT 'ongoing',
    "winnerId" TEXT,
    "stashP1" INTEGER NOT NULL DEFAULT 10,
    "stashP2" INTEGER NOT NULL DEFAULT 10,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CreatureInGame" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "creatureId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "health" INTEGER NOT NULL,
    "storage" INTEGER NOT NULL,
    "row" INTEGER NOT NULL,
    "column" INTEGER NOT NULL,

    CONSTRAINT "CreatureInGame_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HeroInGame" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "heroId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "energy" INTEGER NOT NULL,

    CONSTRAINT "HeroInGame_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Game_player1Id_player2Id_idx" ON "Game"("player1Id", "player2Id");

-- CreateIndex
CREATE INDEX "Game_status_createdAt_idx" ON "Game"("status", "createdAt");

-- AddForeignKey
ALTER TABLE "AbilityInGame" ADD CONSTRAINT "AbilityInGame_creatureInGameId_fkey" FOREIGN KEY ("creatureInGameId") REFERENCES "CreatureInGame"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityInGame" ADD CONSTRAINT "AbilityInGame_heroInGameId_fkey" FOREIGN KEY ("heroInGameId") REFERENCES "HeroInGame"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityInGame" ADD CONSTRAINT "AbilityInGame_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_player1Id_fkey" FOREIGN KEY ("player1Id") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_player2Id_fkey" FOREIGN KEY ("player2Id") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureInGame" ADD CONSTRAINT "CreatureInGame_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureInGame" ADD CONSTRAINT "CreatureInGame_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureInGame" ADD CONSTRAINT "CreatureInGame_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroInGame" ADD CONSTRAINT "HeroInGame_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroInGame" ADD CONSTRAINT "HeroInGame_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroInGame" ADD CONSTRAINT "HeroInGame_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Turn" ADD CONSTRAINT "Turn_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
