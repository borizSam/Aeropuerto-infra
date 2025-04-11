#!/bin/bash
source ./variables.env

echo "🧱 Verificando/creando Log Group para CloudWatch..."

aws logs create-log-group \
  --log-group-name /ecs/aeropuerto-front-task \
  --region $REGION 2>/dev/null

echo "🧱 Registrando Task Definition para el FRONTEND..."

aws ecs register-task-definition \
  --family aeropuerto-front-task \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --cpu "256" \
  --memory "512" \
  --execution-role-arn arn:aws:iam::$ACCOUNT_ID:role/ecsTaskExecutionRole \
  --container-definitions "[  
    {
      \"name\": \"aeropuerto-front\",
      \"image\": \"$IMAGE_FRONT\",
      \"portMappings\": [
        {
          \"containerPort\": 80,
          \"protocol\": \"tcp\"
        }
      ],
      \"essential\": true,
      \"logConfiguration\": {
        \"logDriver\": \"awslogs\",
        \"options\": {
          \"awslogs-group\": \"/ecs/aeropuerto-front-task\",
          \"awslogs-region\": \"$REGION\",
          \"awslogs-stream-prefix\": \"ecs\"
        }
      }
    }
  ]" \
  --region $REGION

