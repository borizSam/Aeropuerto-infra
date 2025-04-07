#!/bin/bash

CLUSTER_NAME="aeropuerto-cluster"
SERVICE_NAME="aeropuerto-backend-service"
TASK_FAMILY="aeropuerto-backend-task"
SECURITY_GROUP_NAME="aeropuerto-sg"
SUBNET_TAG="aeropuerto-subnet"

echo "🔻 Eliminando servicio ECS..."
aws ecs update-service --cluster "$CLUSTER_NAME" --service "$SERVICE_NAME" --desired-count 0
aws ecs delete-service --cluster "$CLUSTER_NAME" --service "$SERVICE_NAME" --force

echo "🧨 Eliminando definición de tarea..."
REVISION=$(aws ecs list-task-definitions --family-prefix "$TASK_FAMILY" --sort DESC --max-items 1 --query "taskDefinitionArns[0]" --output text)
aws ecs deregister-task-definition --task-definition "$REVISION"

echo "🧼 Eliminando subred..."
SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=$SUBNET_TAG" --query "Subnets[0].SubnetId" --output text)
aws ec2 delete-subnet --subnet-id "$SUBNET_ID"

echo "🔐 Eliminando security group..."
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values="$SECURITY_GROUP_NAME" --query "SecurityGroups[0].GroupId" --output text)
aws ec2 delete-security-group --group-id "$SG_ID"

echo "✅ Limpieza completada. Revisa la consola por si algún recurso no fue eliminado."
