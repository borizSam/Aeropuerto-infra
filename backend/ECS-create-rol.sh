## Crear Rol para ejecutar las task dentro del cluster
aws iam create-role \
  --role-name ecsTaskExecutionRoleAeropuerto\
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }'

##Adjuntamos la politica de permisos
aws iam attach-role-policy \
  --role-name ecsTaskExecutionRoleAeropuerto \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
##Una vez creado el rol y adjuntadamos la politica para uqe pueda ejecutar creamos el cluster:
aws ecs create-cluster \
  --cluster-name aeropuerto-cluster \
  --region eu-central-1
##Con esto podemos ver el acount ID de nuestra cuenta en aws 
aws sts get-caller-identity --query Account --output text

##Ahora creamos la task para ejecutarlo en el cluster ojo no se crea la tarea dentro del cluster la tarea se crea para luego ejecutarla en el cluster:

aws ecs register-task-definition \
  --family aeropuerto-back-task \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --cpu "256" \
  --memory "512" \
  --execution-role-arn arn:aws:iam::137068224793:role/ecsTaskExecutionRoleAeropuerto \
  --container-definitions '[
    {
      "name": "aeropuerto-back",
      "image": "borizsam/aeropuerto-back",
      "portMappings": [
        {
          "containerPort": 8080,
          "protocol": "tcp"
        }
      ],
      "essential": true
    }
  ]' \
  --region eu-central-1

##Creamos el service --> donde se ejecutara mi tarea (contenedor que defino en mi task)
#Ejecuta 1 contenedor basado en tu Task Definition (aeropuerto-back-task)
#Lo pone en tu Cluster (aeropuerto-cluster)
#Lo conecta a la Subred y Security Group
#Le asigna una IP pública (para que puedas acceder a tu API)

aws ecs create-service \
  --cluster aeropuerto-cluster \
  --service-name aeropuerto-back-service \
  --task-definition aeropuerto-back-task \
  --launch-type FARGATE \
  --desired-count 1 \
  --network-configuration "awsvpcConfiguration={
    subnets=[subnet-0c078cd0f13374052],
    securityGroups=[sg-04a1d10664b30346a],
    assignPublicIp=ENABLED
  }" \
  --region eu-central-1

  ##para verificar que se esta ejecutando 
  aws ecs list-tasks \
  --cluster aeropuerto-cluster \
  --region eu-central-1