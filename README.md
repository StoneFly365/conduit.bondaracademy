# Karate Template

Refer to the [Getting Started Guide](https://github.com/karatelabs/karate/wiki/Get-Started:-Maven-and-Gradle#github-template) for instructions.

## Guia de Comandos

1. **`mvn test`**: Ejecuta las pruebas del proyecto.  
2. **`mvn clean`**: Limpia los archivos generados en la carpeta `target`.  
3. **`mvn test -X`**: Ejecuta las pruebas mostrando logs en modo debug.  
4. **`mvn clean test`**: Limpia y luego ejecuta las pruebas.  
5. **`mvn clean install -DskipTests`**: Limpia, compila y empaqueta, omitiendo las pruebas.  
6. **`mvn clean install`**: Limpia, compila, empaqueta y ejecuta las pruebas antes de instalar el artefacto.
7. **`mvn test -Dkarate.options="--tags @smokeTest"`**: Ejecuta pruebas sin limpiar los artefactos previos, filtrando por el etiquetado.
8. **`mvn clean test -Dkarate.options="--tags @smokeTest"`**: Limpia el proyecto y asegura una ejecución fresca, filtrando por el etiquetado.
9. **`mvn clean test -Dkarate.options="--tags @wip"`**: Igual que el comando anterior pero filtrando por la etiqueta 'Work in Progress' (caso en desarrollo o pendiente de completarse).
10. **`mvn test -Dkarate.options="--tags @smokeTest" -Dkarate.parallel=true`**: Ejecuta pruebas en paralelo.
11. **`mvn clean install -U`**: Actualiza las dependencias y limpia los problemas cacheados.
12. **`mvn test -Dkarate.options="--tags @smokeTest --tags ~@skipme"`**: Ejecuta las pruebas etiquetadas con `@smokeTest` e ignora los escenarios marcados con `@skipme`. Para que el comando funcione correctamente, asegúrate de añadir estas etiquetas a nivel de **feature** o **scenario**, según corresponda.
13. **`mvn test -Dkarate.options="--tags @wip" -Dkarate.env="dev"`**: Ejecuta las pruebas etiquetadas con el tag wip y en el entorno dev. Dado que dev es el entorno por defecto, no sería necesario especificarlo como parámetro en el comando.
14. **`for i in {1..3}; do mvn clean test -Dkarate.options="--tags @smokeTest"; done`**: Ejecuta las pruebas con el tag `@smokeTest` en un bucle de **Bash**, repitiendo la ejecución 3 veces. Puedes modificar el número (`3`) según tus necesidades.

## Tags para filtrar las pruebas
### 1. Control de Ejecución:

-   `@ignore`: Evita que un escenario o conjunto de escenarios se ejecute.
    
-   `@skipme`: Similar a `@ignore`, usado para omitir pruebas específicas.
    
-   `@failed`: Indica que el escenario está marcado como fallido para realizar pruebas de corrección más adelante.
    
### 2. Gestión de Entornos:

-   `@env=env_name`: Define un entorno específico, útil para cambiar configuraciones en tiempo de ejecución.

### 3. Tipos de Pruebas:

-   `@regression`: Indica pruebas de regresión.

-   `@smokeTest`: Marca escenarios como pruebas de humo.

-   `@performance`: Identifica pruebas de rendimiento.
    
### 4. Integración y Reportes:

-   `@report`: Incluye el escenario en los reportes de prueba.
    
-   `@notreport`: Excluye el escenario de los reportes.

### 5. Clasificación Personalizada:

-   `@custom_tag`: Puedes definir tus propios tags para agrupar pruebas. Ejemplo: @login, @payment.

### 6. Compatibilidad y Debugging:

-   `@wip`: Indica que el escenario está en progreso.
    
-   `@debug`: Activa configuraciones especiales de depuración.
    

----------

### Uso en la Línea de Comandos:

Ejecuta escenarios específicos usando tags:

    mvn  test  -Dkarate.options="--tags  @regression"

## Docker

Correr la imagen Docker y ejecutar el contenedor

    docker build -t karatetest .

Ejecutar el contenedor

    docker run -it karatetest

Ejecutar el orquestador docker-compose

    docker-compose up --build

Detener el contenedor (si está en modo up)

    docker-compose down
