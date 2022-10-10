# paso a paso del setup

- crear bucket a mano iac-tf-bucket-s3-ls88-v2
- crear el rol Role_devsecops con permisos de AdministratorFullAccess. FSFullAccess. STSFullAccess.
- Realizar adecuaciones propias de cada ambiente, nombre del bucket, nombre del rol, cuenta y ARN del rol.
- Agregar en github los secret de Synk , secret_id, secret_key.
- Solucionar y documentar error del api-gateway y alias domain.




# 
- OPCIONAL:
    > Levantar un sonar y agregar al pipeline
    > Implementar un gestor de vulnerability Defectdojo / Arcery / Faraday (demo)

