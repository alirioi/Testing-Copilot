# Proyecto de Minimal API con .NET

Este proyecto genera automáticamente una solución de .NET que incluye una Minimal API, un proyecto de pruebas unitarias y un archivo Docker para su despliegue. Todo esto se realiza mediante el script `generador.sh`.

## Estructura del Proyecto

La carpeta `Proyecto` contiene la siguiente estructura:

```bash
Proyecto/
├── generador.sh                # Script para generar la solución y proyectos
├── ProyectoCopilot.sln         # Archivo de solución de .NET
├── ProyectoCopilot/            # Proyecto principal de Minimal API
│   ├── appsettings.json        # Configuración de la aplicación
│   ├── Dockerfile              # Archivo Docker para el despliegue
│   ├── Program.cs              # Punto de entrada de la aplicación
│   ├── ProyectoCopilot.csproj  # Archivo de configuración del proyecto
│   └── Properties/
│       └── launchSettings.json # Configuración de lanzamiento
├── ProyectoCopilot.Tests/      # Proyecto de pruebas unitarias
│   ├── ProyectoCopilot.Tests.csproj # Archivo de configuración del proyecto de pruebas
│   └── UnitTest1.cs            # Ejemplo de prueba unitaria
```

## Uso del Script `generador.sh`

El script `generador.sh` automatiza la creación de un proyecto de Minimal API con las siguientes características:

1. **Crea un proyecto de Minimal API**: Genera un proyecto base con `dotnet new webapi`.
2. **Crea un proyecto de pruebas unitarias**: Genera un proyecto de pruebas con `dotnet new xunit`.
3. **Asocia los proyectos**: Vincula el proyecto de pruebas con el proyecto principal.
4. **Crea una solución**: Genera un archivo `.sln` y agrega ambos proyectos.
5. **Agrega paquetes necesarios**: Instala paquetes como `Microsoft.AspNetCore.Mvc.Testing` y `MiniValidation` para facilitar las pruebas.
6. **Genera un archivo Docker**: Crea un `Dockerfile` para construir y ejecutar la aplicación en un contenedor.

### Ejecución del Script

Para usar el script, sigue estos pasos:

1. Asegúrate de que tienes instalado .NET SDK y Docker.
2. Navega a la carpeta `Proyecto` en tu terminal.
3. Ejecuta el script proporcionando un nombre para el proyecto:

   ```bash
   ./generador.sh <NombreDelProyecto>
   ```

   Por ejemplo:

   ```bash
   ./generador.sh ProyectoCopilot
   ```

### Resultado

El script generará:

- Una solución `.sln` con un proyecto de Minimal API y un proyecto de pruebas.
- Un archivo `Dockerfile` para construir y ejecutar la aplicación en un contenedor.

## Despliegue con Docker

Para ejecutar la aplicación en un contenedor Docker:

1. Navega al directorio del proyecto generado:

   ```bash
   cd ProyectoCopilot
   ```

2. Construye la imagen Docker:

   ```bash
   docker build -t proyectocopilot .
   ```

3. Ejecuta el contenedor:

   ```bash
   docker run -p 80:80 proyectocopilot
   ```

4. Accede a la API en `http://localhost`.

## Contribuciones

Si deseas mejorar este proyecto, puedes modificar el script `generador.sh` o los archivos generados. ¡Las contribuciones son bienvenidas!
