start cmd /k "npm run gateway"
timeout /t 2
start cmd /k "npx ts-node processador.ts"
timeout /t 2
start cmd /k "npx ts-node cloud.ts"
timeout /t 2
start cmd /k "npx ts-node sensor.ts Centro 5000"
start cmd /k "npx ts-node sensor.ts Norte 5001"
start cmd /k "npx ts-node sensor.ts Sul 5002"
start cmd /k "npx ts-node sensor.ts Leste 5003"
start cmd /k "npx ts-node sensor.ts Oeste 5004"


/pause