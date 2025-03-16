/*
  Warnings:

  - You are about to drop the `CreatureAbility` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "CreatureAbility" DROP CONSTRAINT "CreatureAbility_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "CreatureAbility" DROP CONSTRAINT "CreatureAbility_creatureId_fkey";

-- DropTable
DROP TABLE "CreatureAbility";

-- CreateTable
CREATE TABLE "CardAbility" (
    "id" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,

    CONSTRAINT "CardAbility_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CardAbility_cardId_abilityId_key" ON "CardAbility"("cardId", "abilityId");

-- AddForeignKey
ALTER TABLE "CardAbility" ADD CONSTRAINT "CardAbility_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardAbility" ADD CONSTRAINT "CardAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
