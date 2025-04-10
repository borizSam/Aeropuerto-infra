#!/bin/bash
source ./variables.env

echo "🚀 Lanzando servicio FRONTEND en ECS..."

aws ecs create-service \
  --cluster $CLUSTER_NAME \
  --service-name aeropuerto-front-service \
  --task-definition aeropuerto-front-task \
  --launch-type FARGATE \
  --desired-count 1 \
  --network-configuration "awsvpcConfiguration={
    subnets=[$SUBNET_ID],
    securityGroups=[$SG_FRONT],
    assignPublicIp=ENABLED
  }" \
  --region $REGION
