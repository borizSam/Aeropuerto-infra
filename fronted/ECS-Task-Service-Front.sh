aws ecs register-task-definition \
  --family aeropuerto-front-task \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --cpu "256" \
  --memory "512" \
  --execution-role-arn arn:aws:iam::137068224793:role/ecsTaskExecutionRole \
  --container-definitions '[
    {
      "name": "aeropuerto-front",
      "image": "borizsam/aeropuerto-front",
      "portMappings": [
        {
          "containerPort": 80,
          "protocol": "tcp"
        }
      ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/aeropuerto-front-task",
          "awslogs-region": "eu-central-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]' \
  --region eu-central-1
