#!/bin/bash
source ./variables.env

echo "🧱 Verificando/creando Log Group para CloudWatch..."

aws logs create-log-group \
  --log-group-name /ecs/aeropuerto-back-task \
  --region $REGION 2>/dev/null

echo "🧱 Registrando Task Definition para el BACKEND..."

aws ecs register-task-definition \
  --family aeropuerto-back-task \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --cpu "256" \
  --memory "512" \
  --execution-role-arn arn:aws:iam::$ACCOUNT_ID:role/ecsTaskExecutionRole \
  --container-definitions "[  
    {
      \"name\": \"aeropuerto-back\",
      \"image\": \"$IMAGE_BACK\",
      \"portMappings\": [
        {
          \"containerPort\": 8080,
          \"protocol\": \"tcp\"
        }
      ],
      \"essential\": true,
      \"logConfiguration\": {
        \"logDriver\": \"awslogs\",
        \"options\": {
          \"awslogs-group\": \"/ecs/aeropuerto-back-task\",
          \"awslogs-region\": \"$REGION\",
          \"awslogs-stream-prefix\": \"ecs\"
        }
      }
    }
  ]" \
  --region $REGION

