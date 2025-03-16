/*
  Warnings:

  - You are about to drop the column `gameId` on the `CompletedMatch` table. All the data in the column will be lost.
  - You are about to drop the column `action` on the `Turn` table. All the data in the column will be lost.
  - Added the required column `gameData` to the `CompletedMatch` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CompletedMatch" DROP CONSTRAINT "CompletedMatch_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameCard" DROP CONSTRAINT "GameCard_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameCardAbility" DROP CONSTRAINT "GameCardAbility_gameCardId_fkey";

-- DropIndex
DROP INDEX "CompletedMatch_gameId_key";

-- AlterTable
ALTER TABLE "CompletedMatch" DROP COLUMN "gameId",
ADD COLUMN     "gameData" JSONB NOT NULL;

-- AlterTable
ALTER TABLE "Turn" DROP COLUMN "action";

-- CreateTable
CREATE TABLE "TurnPhase" (
    "id" TEXT NOT NULL,
    "turnId" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "phase" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "target" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TurnPhase_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "TurnPhase" ADD CONSTRAINT "TurnPhase_turnId_fkey" FOREIGN KEY ("turnId") REFERENCES "Turn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TurnPhase" ADD CONSTRAINT "TurnPhase_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCard" ADD CONSTRAINT "GameCard_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "LiveGame"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCardAbility" ADD CONSTRAINT "GameCardAbility_gameCardId_fkey" FOREIGN KEY ("gameCardId") REFERENCES "GameCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;
