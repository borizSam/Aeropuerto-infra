#!/bin/bash

REGION="eu-central-1"
VPC_ID=$(cat vpc-id.txt)

echo "🌐 Creando Internet Gateway..."
IGW_ID=$(aws ec2 create-internet-gateway \
  --region $REGION \
  --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=aeropuerto-igw}]' \
  --query 'InternetGateway.InternetGatewayId' --output text)

aws ec2 attach-internet-gateway \
  --internet-gateway-id $IGW_ID \
  --vpc-id $VPC_ID \
  --region $REGION

echo "✅ IGW creado y adjuntado: $IGW_ID"
echo $IGW_ID > igw-id.txt
