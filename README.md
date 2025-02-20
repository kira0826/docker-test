Kevin Steven Nieto Curaca

Primero construí el dockerfile teniendo en cuenta el entorno que se definía en el readme.  Busqué el scrip  configurado para correr la app tal que la ejecucución es con `npm run dev` 

Para la parte del acceso generé un acces token con permisos de Wirite and Read para usarlo como password en las secrets, tal que: 

![image.png](attachment:c4e90620-8179-4c75-82ef-cdf04652f5be:image.png)

![image.png](attachment:11c89ed7-4fbf-49e9-997e-06cf4accce3c:image.png)

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

 

![image.png](attachment:bab62380-6274-44b6-92a1-c5e735a7ba78:image.png)

Imagen en docker-hub

![image.png](attachment:10f3233e-0c6d-4190-9d05-84209273fc95:image.png)
