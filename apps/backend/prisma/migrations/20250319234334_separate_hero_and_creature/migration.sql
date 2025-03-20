/*
  Warnings:

  - You are about to drop the column `cardId` on the `GameCard` table. All the data in the column will be lost.
  - You are about to drop the `Card` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CardAbility` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DeckCard` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "CardAbility" DROP CONSTRAINT "CardAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "CardAbility" DROP CONSTRAINT "CardAbility_cardId_fkey";

-- DropForeignKey
ALTER TABLE "DeckCard" DROP CONSTRAINT "DeckCard_cardId_fkey";

-- DropForeignKey
ALTER TABLE "DeckCard" DROP CONSTRAINT "DeckCard_deckId_fkey";

-- DropForeignKey
ALTER TABLE "GameCard" DROP CONSTRAINT "GameCard_cardId_fkey";

-- AlterTable
ALTER TABLE "GameCard" DROP COLUMN "cardId",
ADD COLUMN     "creatureId" TEXT,
ADD COLUMN     "heroId" TEXT;

-- DropTable
DROP TABLE "Card";

-- DropTable
DROP TABLE "CardAbility";

-- DropTable
DROP TABLE "DeckCard";

-- CreateTable
CREATE TABLE "DeckHero" (
    "id" TEXT NOT NULL,
    "deckId" TEXT NOT NULL,
    "heroId" TEXT NOT NULL,

    CONSTRAINT "DeckHero_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DeckCreature" (
    "id" TEXT NOT NULL,
    "deckId" TEXT NOT NULL,
    "creatureId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "DeckCreature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Creature" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "health" INTEGER NOT NULL,
    "temperament" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,

    CONSTRAINT "Creature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Hero" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,

    CONSTRAINT "Hero_pkey" PRIMARY KEY ("id")
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
CREATE TABLE "CreatureAbility" (
    "id" TEXT NOT NULL,
    "creatureId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,

    CONSTRAINT "CreatureAbility_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HeroAbility" (
    "id" TEXT NOT NULL,
    "heroId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,
    "conditions" JSONB NOT NULL,

    CONSTRAINT "HeroAbility_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DeckHero_deckId_key" ON "DeckHero"("deckId");

-- CreateIndex
CREATE UNIQUE INDEX "Creature_name_key" ON "Creature"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Hero_name_key" ON "Hero"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CreatureAbility_creatureId_abilityId_key" ON "CreatureAbility"("creatureId", "abilityId");

-- AddForeignKey
ALTER TABLE "DeckHero" ADD CONSTRAINT "DeckHero_deckId_fkey" FOREIGN KEY ("deckId") REFERENCES "Deck"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckHero" ADD CONSTRAINT "DeckHero_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckCreature" ADD CONSTRAINT "DeckCreature_deckId_fkey" FOREIGN KEY ("deckId") REFERENCES "Deck"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckCreature" ADD CONSTRAINT "DeckCreature_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityAction" ADD CONSTRAINT "AbilityAction_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreatureAbility" ADD CONSTRAINT "CreatureAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroAbility" ADD CONSTRAINT "HeroAbility_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroAbility" ADD CONSTRAINT "HeroAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCard" ADD CONSTRAINT "GameCard_creatureId_fkey" FOREIGN KEY ("creatureId") REFERENCES "Creature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCard" ADD CONSTRAINT "GameCard_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE SET NULL ON UPDATE CASCADE;
