Kevin Steven Nieto Curaca

Primero construí el dockerfile teniendo en cuenta el entorno que se definía en el readme.  Busqué el scrip  configurado para correr la app tal que la ejecucución es con `npm run dev` 

Para la parte del acceso generé un acces token con permisos de Wirite and Read para usarlo como password en las secrets, tal que: 

![image](https://github.com/user-attachments/assets/f16da38b-9f9f-418b-8ed4-9620169bafb0)

![image](https://github.com/user-attachments/assets/182d8a7b-bc04-47cd-b28f-1577e9c7e222)

Con ello ya podía configurar el workflow tal que guiandome con lo que hice en el taller de microservicios contruí esto:

```yaml
name: Docker Build and Push  # Nombre del workflow en GitHub Actions

on:
  push:
    branches:
      - main  # Se ejecuta cuando hay un push a la rama 'main'

jobs:
  build-and-push:
    runs-on: ubuntu-latest  # Se ejecuta en un runner con Ubuntu
    environment: prod  # Define el entorno de ejecución como 'prod'

    steps:
      - name: Checkout del código
        uses: actions/checkout@v4  # Obtiene el código del repositorio

      - name: Configurar Docker Buildx
        uses: docker/setup-buildx-action@v3  # Habilita Docker Buildx para una construcción optimizada

      - name: Iniciar sesión en DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}  # Usa el nombre de usuario almacenado en GitHub Secrets
          password: ${{ secrets.DOCKER_PASSWORD }}  # Usa la contraseña o token almacenado en GitHub Secrets

      - name: Construir y subir la imagen a DockerHub
        uses: docker/build-push-action@v5
        with:
          context: .  # Usa el directorio actual como contexto de construcción
          file: ./Dockerfile  # Especifica el Dockerfile a usar
          push: true  # Indica que la imagen debe ser subida a DockerHub
          tags: kira0826/taller:latest  # Etiqueta de la imagen en DockerHub
```

Establecí el ambiente que creé con `environment` , y luego ejecute dando como resultado exitoso la action: 

 

![image](https://github.com/user-attachments/assets/f421fb7e-89bc-4ced-8955-b81feeebe212)


Imagen en docker-hub

![image](https://github.com/user-attachments/assets/dd244633-0a01-49cd-ab54-f03eeb9d96d3)

