#!/bin/bash

# Verifica si se proporcionó un nombre de proyecto
if [ -z "$1" ]; then
  echo "Por favor, proporciona un nombre para los proyectos."
  echo "Uso: ./generador.sh <NombreDelProyecto>"
  exit 1
fi

# Asigna el nombre del proyecto a una variable
PROJECT_NAME=$1

# Crea un proyecto de minimal api de .net
echo "CREANDO PROYECTO DE MINIMAL API DE .NET"
dotnet new webapi -n $PROJECT_NAME

# Crea un proyecto de pruebas para el proyecto de minimal api de .net
echo "CREANDO PROYECTO DE PRUEBAS PARA EL PROYECTO DE MINIMAL API DE .NET"
dotnet new xunit -n ${PROJECT_NAME}.Tests

# Asocia los dos proyectos
echo "ASOCIANDO LOS DOS PROYECTOS"
dotnet add ${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj reference $PROJECT_NAME/$PROJECT_NAME.csproj

# Crea un archivo de solución
echo "CREANDO UN ARCHIVO DE SOLUCIÓN"
dotnet new sln -n $PROJECT_NAME

# Agrega ambos proyectos a la solución
echo "AGREGANDO AMBOS PROYECTOS A LA SOLUCIÓN"
dotnet sln ${PROJECT_NAME}.sln add $PROJECT_NAME/$PROJECT_NAME.csproj
dotnet sln ${PROJECT_NAME}.sln add ${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj

# Agrega los paquetes necesarios para el proyecto de test de minimal api de .net
echo "AGREGANDO LOS PAQUETES NECESARIOS PARA EL PROYECTO DE TEST DE MINIMAL API DE .NET"
dotnet add ${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj package Microsoft.AspNetCore.Mvc.Testing
dotnet add ${PROJECT_NAME}.Tests/${PROJECT_NAME}.Tests.csproj package MiniValidation

# Agrega un archivo de Docker en el proyecto de minimal api de .net
echo "AGREGANDO UN ARCHIVO DE DOCKER EN EL PROYECTO DE MINIMAL API DE .NET"

cd ${PROJECT_NAME}

cat <<EOL > Dockerfile
# Use the official .NET SDK image as a build stage.
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Copy the project file and restore the dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image as a runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=base /app/out .

# Expose the port the app runs on
EXPOSE 80

# Run the app
ENTRYPOINT ["dotnet", "$PROJECT_NAME.dll"]
EOL

echo "ARCHIVO DE DOCKER AGREGADO"

cd ..

echo "PROYECTO CREADO CON ÉXITO"