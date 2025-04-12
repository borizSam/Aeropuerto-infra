# ⚙️ Infraestructura - AWS ECS con Fargate (DevOps)

## Descripción
Contiene scripts bash para desplegar el sistema en AWS utilizando **ECS Fargate**. Los contenedores se obtienen desde Docker Hub, gracias a un pipeline automatizado con GitHub Actions.

## Componentes
- **VPC y Subnets** (directorio `VPC-Subnets`)
- **ECS Task Definitions** (scripts de `create-*`)
- **ECS Services** (para frontend y backend)
- **Variables de entorno** (`variables.env`)
- **Cleanup scripts** (para remover servicios antiguos)

## Despliegue

1. Configura tus variables en `scripts-V1/variables.env`
2. Ejecuta:

```bash
source scripts-V1/variables.env

# Crear definiciones de tareas
bash scripts-V1/create-backend-task.sh
bash scripts-V1/create-frontend-task.sh

# Crear servicios en ECS
bash scripts-V1/create-backend-service.sh
bash scripts-V1/create-frontend-service.sh
```

## Limpieza
```bash
bash scripts/cleanup-backend.sh
```
## Diagrama
![Diagrama de flujo](https://raw.githubusercontent.com/borizSam/Photos/refs/heads/main/Diagrama.jpg.png)
