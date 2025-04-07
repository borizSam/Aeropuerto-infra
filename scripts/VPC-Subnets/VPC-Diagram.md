``` bash
                            INTERNET
                                ▲
                                │
                        ┌───────┴────────┐
                        │ Internet       │
                        │ Gateway (IGW)  │
                        └──────┬─────────┘
                               │
                ┌──────────────▼─────────────┐
                │          VPC               │
                │      10.0.0.0/16           │
                └────────────┬───────────────┘
                             │
                   ┌─────────▼────────────┐
                   │   Subred Pública     │
                   │   10.0.1.0/24        │
                   └─────────┬────────────┘
                             │
                    ┌────────▼────────┐
                    │ Route Table     │
                    │ 0.0.0.0/0 → IGW │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │ Security Group  │
                    │ Permite tráfico │
                    │ a puerto 8080   │
                    └─────────────────┘
```
## VPC (/16)	
Tu red virtual privada. Gran bloque IP. Ej: 10.0.0.0/16 = 65,536 IPs.
## Subred (/24)	
Una parte más pequeña de la VPC. Ej: 10.0.1.0/24 = 256 IPs. Se usa para agrupar recursos (públicos o privados).
## Internet Gateway	
Permite a los recursos dentro de tu VPC salir y recibir tráfico desde Internet.
## Route Table	
Define cómo el tráfico sale desde tu subred (por ejemplo: “todo lo que no es interno, mándalo por la IGW”).
## Security Group	
Firewall virtual. Controla qué tráfico entra/sale a recursos como ECS o EC2. En este caso, permitimos puerto 8080.
