##Una vez tengamos el servicio lanzado podemos hacer el rebuild con un force
aws ecs update-service \
  --cluster aeropuerto-cluster \
  --service aeropuerto-front-service \
  --force-new-deployment \
  --region eu-central-1

  aws ecs update-service \
  --cluster aeropuerto-cluster \
  --service aeropuerto-back-service \
  --force-new-deployment \
  --region eu-central-1

