/*
  Warnings:

  - You are about to drop the column `value` on the `Ability` table. All the data in the column will be lost.
  - The primary key for the `AbilityAction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `action` on the `AbilityAction` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `AbilityAction` table. All the data in the column will be lost.
  - Added the required column `actionId` to the `AbilityAction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Ability" DROP COLUMN "value";

-- AlterTable
ALTER TABLE "AbilityAction" DROP CONSTRAINT "AbilityAction_pkey",
DROP COLUMN "action",
DROP COLUMN "id",
ADD COLUMN     "actionId" TEXT NOT NULL,
ADD CONSTRAINT "AbilityAction_pkey" PRIMARY KEY ("abilityId", "actionId");

-- CreateTable
CREATE TABLE "Action" (
    "id" TEXT NOT NULL,
    "action" "AbilityActionType" NOT NULL,

    CONSTRAINT "Action_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Value" (
    "id" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,

    CONSTRAINT "Value_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AbilityValue" (
    "abilityId" TEXT NOT NULL,
    "valueId" TEXT NOT NULL,

    CONSTRAINT "AbilityValue_pkey" PRIMARY KEY ("abilityId","valueId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Action_action_key" ON "Action"("action");

-- AddForeignKey
ALTER TABLE "AbilityAction" ADD CONSTRAINT "AbilityAction_actionId_fkey" FOREIGN KEY ("actionId") REFERENCES "Action"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityValue" ADD CONSTRAINT "AbilityValue_abilityId_fkey" FOREIGN KEY ("abilityId") REFERENCES "Ability"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AbilityValue" ADD CONSTRAINT "AbilityValue_valueId_fkey" FOREIGN KEY ("valueId") REFERENCES "Value"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
