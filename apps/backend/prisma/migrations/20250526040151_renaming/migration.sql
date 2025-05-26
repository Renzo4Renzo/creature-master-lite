/*
  Warnings:

  - You are about to drop the `HeroAbilityOption` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "HeroAbilityOption" DROP CONSTRAINT "HeroAbilityOption_abilityId_fkey";

-- DropForeignKey
ALTER TABLE "HeroAbilityOption" DROP CONSTRAINT "HeroAbilityOption_heroId_fkey";

-- DropTable
DROP TABLE "HeroAbilityOption";

-- CreateTable
CREATE TABLE "HeroAbility" (
    "id" TEXT NOT NULL,
    "heroId" TEXT NOT NULL,
    "abilityId" TEXT NOT NULL,
    "cost" INTEGER NOT NULL,

    CONSTRAINT "HeroAbility_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "HeroAbility" ADD CONSTRAINT "HeroAbility_heroId_fkey" FOREIGN KEY ("heroId") REFERENCES "Hero"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HeroAbility" ADD CONSTRAINT "HeroAbility_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
