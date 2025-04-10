aws ecs create-service \
  --cluster aeropuerto-cluster \
  --service-name aeropuerto-front-service \
  --task-definition aeropuerto-front-task \
  --launch-type FARGATE \
  --desired-count 1 \
  --network-configuration "awsvpcConfiguration={
    subnets=[subnet-0c078cd0f13374052],
    securityGroups=[sg-0f6f53a6075051af2],
    assignPublicIp=ENABLED
  }" \
  --region eu-central-1
