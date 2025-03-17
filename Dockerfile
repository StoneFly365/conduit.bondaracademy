# Usar la imagen oficial de Maven 3.9.9 con JDK 11
FROM maven:3.9.9

# Definir el directorio de trabajo
WORKDIR /usr/src/app

# Copiar el archivo pom.xml y descargar las dependencias
COPY pom.xml /usr/src/app

# Copiar todo el proyecto
COPY . /usr/src/app

# Descargar dependencias sin ejecutar pruebas
RUN mvn dependency:go-offline -B

# Copiar el código fuente del proyecto
# COPY src /app/src

# Ejecutar pruebas de Karate
CMD ["mvn", "clean", "test", "-Dkarate.options=--tags @smokeTest"]
