aws ec2 create-security-group \
  --group-name aeropuerto-frontend-sg \
  --description "Permite trafico HTTP al frontend" \
  --vpc-id vpc-0d544762599a16e81 \
  --region eu-central-1


#2: Abrir el puerto 80 (HTTP) al mundo

aws ec2 authorize-security-group-ingress \
  --group-id sg-0f6f53a6075051af2 \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0 \
  --region eu-central-1
