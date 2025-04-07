#!/bin/bash

REGION="eu-central-1"
VPC_ID=$(cat vpc-id.txt)
IGW_ID=$(cat igw-id.txt)
SUBNET_ID=$(cat subnet-id.txt)

echo "🛣️ Creando tabla de rutas..."
ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --region $REGION \
  --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=aeropuerto-rt}]' \
  --query 'RouteTable.RouteTableId' --output text)

echo "🔗 Asociando ruta 0.0.0.0/0 → IGW..."
aws ec2 create-route \
  --route-table-id $ROUTE_TABLE_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID \
  --region $REGION

echo "🔗 Asociando tabla de rutas con la subred..."
aws ec2 associate-route-table \
  --route-table-id $ROUTE_TABLE_ID \
  --subnet-id $SUBNET_ID \
  --region $REGION

echo "✅ Tabla de rutas lista y asociada: $ROUTE_TABLE_ID"
echo $ROUTE_TABLE_ID > route-table-id.txt
