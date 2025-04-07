#!/bin/bash

REGION="eu-central-1"
VPC_CIDR="10.0.0.0/16"

echo "🔧 Creando VPC..."
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --region $REGION \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=aeropuerto-vpc}]' \
  --query 'Vpc.VpcId' --output text)

echo "✅ VPC creada: $VPC_ID"
echo $VPC_ID > vpc-id.txt
