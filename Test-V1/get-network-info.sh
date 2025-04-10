#!/bin/bash

REGION="eu-central-1"

echo "📦 Obteniendo información de red en región: $REGION"
echo "---------------------------------------------"

echo "🧠 CLUSTERS ECS:"
aws ecs list-clusters --region $REGION

echo ""
echo "🌐 VPCs disponibles:"
aws ec2 describe-vpcs \
  --region $REGION \
  --query "Vpcs[*].{VpcId:VpcId,CIDR:CidrBlock}" \
  --output table

echo ""
echo "📍 Subnets disponibles:"
aws ec2 describe-subnets \
  --region $REGION \
  --query "Subnets[*].{SubnetId:SubnetId,AZ:AvailabilityZone,CIDR:CidrBlock}" \
  --output table

echo ""
echo "🛡 Security Groups:"
aws ec2 describe-security-groups \
  --region $REGION \
  --query "SecurityGroups[*].{Name:GroupName,ID:GroupId,Desc:Description}" \
  --output table

echo ""
echo "🎯 Target Groups (si ya tenés alguno para ECS):"
aws elbv2 describe-target-groups \
  --region $REGION \
  --query "TargetGroups[*].{Name:TargetGroupName,ARN:TargetGroupArn,Port:Port}" \
  --output table

echo ""
echo "✅ Listo. Copiame los valores relevantes (VPC, Subnets, SG, Cluster) para armarte los scripts"
