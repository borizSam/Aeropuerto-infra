#!/bin/bash

REGION="eu-central-1"
VPC_ID=$(cat vpc-id.txt)

echo "🛡️ Creando Security Group..."
SG_ID=$(aws ec2 create-security-group \
  --group-name aeropuerto-backend-sg \
  --description "Permite tráfico HTTP al backend en puerto 8080" \
  --vpc-id $VPC_ID \
  --region $REGION \
  --query 'GroupId' --output text)

echo "🔓 Abriendo puerto 8080 para todo el mundo..."
aws ec2 authorize-security-group-ingress \
  --group-id $SG_ID \
  --protocol tcp \
  --port 8080 \
  --cidr 0.0.0.0/0 \
  --region $REGION

echo "✅ Security Group creado y configurado: $SG_ID"
echo $SG_ID > sg-id.txt
