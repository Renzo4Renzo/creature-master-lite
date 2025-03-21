/*
  Warnings:

  - A unique constraint covering the columns `[playerId]` on the table `MatchmakingQueue` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE INDEX "CompletedMatch_createdAt_idx" ON "CompletedMatch"("createdAt");

-- CreateIndex
CREATE INDEX "GameCreature_gameId_ownerId_idx" ON "GameCreature"("gameId", "ownerId");

-- CreateIndex
CREATE INDEX "GameHero_gameId_ownerId_idx" ON "GameHero"("gameId", "ownerId");

-- CreateIndex
CREATE INDEX "LiveGame_status_createdAt_idx" ON "LiveGame"("status", "createdAt");

-- CreateIndex
CREATE INDEX "MatchmakingQueue_createdAt_playerId_idx" ON "MatchmakingQueue"("createdAt", "playerId");

-- CreateIndex
CREATE UNIQUE INDEX "MatchmakingQueue_playerId_key" ON "MatchmakingQueue"("playerId");
