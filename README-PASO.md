# Setup

- crear bucket a mano iac-tf-bucket-s3-ls88-v3
- crear el rol Role_devsecops con permisos de AdministratorFullAccess.
- Modificar el nombre del bucket, cuenta, rol y arn en archivos terraform
- Realizar adecuaciones propias de cada ambiente, nombre del bucket, nombre del rol, cuenta y ARN del rol.
- Agregar en github los secret de Synk , secret_id, secret_key.


TODO
- Solucionar y documentar error del api-gateway y alias domain.

El proceso correcto para salvar el error es crear a mano el "custom domain name" desde el servicio de API Gateway se debe configurar:
1.- Domain name: api.dominio-example.com
2.- TLS: version de TLS (ej TLS 1.2)
3.- Endpoint type: Regional 
4.- ACM: se debe elegir el certificado que corresponde al certificado.
5.- TAGS: agregar si considera necesario.

Luego crear el nombre de dominio y resta el mapping que se realiza con el despliegue por lo cual se debe volver a ejecutar el terraform apply.





# 
- OPCIONAL:
    > Levantar un sonar y agregar al pipeline
    > Implementar un gestor de vulnerability Defectdojo / Arcery / Faraday (demo)

