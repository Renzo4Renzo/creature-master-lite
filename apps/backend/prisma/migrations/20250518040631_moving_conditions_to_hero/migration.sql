/*
  Warnings:

  - You are about to drop the column `conditions` on the `HeroAbility` table. All the data in the column will be lost.
  - Added the required column `conditions` to the `Hero` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Hero" ADD COLUMN     "conditions" JSONB NOT NULL;

-- AlterTable
ALTER TABLE "HeroAbility" DROP COLUMN "conditions";
