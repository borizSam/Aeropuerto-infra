#!/bin/bash
source ./variables.env

echo "🚀 Lanzando servicio BACKEND en ECS..."

aws ecs create-service \
  --cluster $CLUSTER_NAME \
  --service-name aeropuerto-back-service \
  --task-definition aeropuerto-back-task \
  --launch-type FARGATE \
  --desired-count 1 \
  --network-configuration "awsvpcConfiguration={
    subnets=[$SUBNET_ID],
    securityGroups=[$SG_BACK],
    assignPublicIp=ENABLED
  }" \
  --region $REGION
