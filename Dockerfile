# Usa una imagen ligera de Node.js 18
FROM node:18-alpine  

# Define el directorio de trabajo
WORKDIR /app  

# Copia archivos de dependencias e instala paquetes
COPY package.json package-lock.json ./  
RUN npm install --frozen-lockfile  

# Copia el resto del código
COPY . .  

# Expone el puerto de la aplicación
EXPOSE 3000  

# Ejecuta la app en modo desarrollo
CMD ["npm", "run", "dev"]  
