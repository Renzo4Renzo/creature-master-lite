# Creature Master Lite

TIME TO DUEL!

## Database Credentials (Local)

POSTGRES_USER=admin
POSTGRES_PASSWORD=secret
POSTGRES_DB=creature_master
PORT=5432

## Running Migrations

npx prisma migrate dev --name [your_name]

## HeroAbility - How to store conditions (to trigger abilities)?

Example:

- 1st Hero `{ "temperament": { "Phlegmatic": "Resurrection" }, "default": "Detonator" }`
- 2nd Hero `{ "temperament": { "Choleric": "Evolution (+2)" }, "default": "Neutralize" }`
- 3rd Hero `{ "ownership": { "own": "Expulsion" }, "default": "Paralysis" }`
- 4th Hero `{ "ownership": { "enemy": "Detonator" }, "default": "Drain (-2)" }`
- 5th Hero `{ "temperament": { "Phlegmatic": "Jeez", "Choleric": "Yeet" }, "default": "Bomb" }`

## CreatureAbility - How to store abilities?
