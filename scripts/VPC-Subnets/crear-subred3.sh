#!/bin/bash

REGION="eu-central-1"
AZ="eu-central-1a"
SUBNET_CIDR="10.0.1.0/24"
VPC_ID=$(cat vpc-id.txt)

echo "🟨 Creando subred pública..."
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_CIDR \
  --availability-zone $AZ \
  --region $REGION \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=aeropuerto-subnet}]' \
  --query 'Subnet.SubnetId' --output text)

# Habilitar IP pública automática
aws ec2 modify-subnet-attribute \
  --subnet-id $SUBNET_ID \
  --map-public-ip-on-launch \
  --region $REGION

echo "✅ Subred creada: $SUBNET_ID"
echo $SUBNET_ID > subnet-id.txt
