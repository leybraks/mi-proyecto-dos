#!/bin/bash
# Script de Despliegue Robusto
# Recuerda: Ejecútalo desde el directorio del proyecto (cd mi-proyecto-dos)

echo "--- INICIANDO DESPLIEGUE CONTINUO V2 ---"

# 1. Actualizar el codigo fuente
echo "-> 1. Descargando la ultima version del codigo de GitHub..."
git pull origin master

if [ $? -ne 0 ]; then
    echo "ERROR: Falló la descarga del codigo. Abortando."
    exit 1
fi
echo "Codigo actualizado."

# 2. Detener y eliminar contenedores antiguos
echo "-> 2. Deteniendo y eliminando la infraestructura anterior (limpieza)..."
# La opción '-v' asegura que se eliminen los volumenes anónimos (aunque usamos nombrado)
# ¡Nota! docker-compose down NO elimina los volumenes nombrados por defecto.
docker-compose down 

echo "Infraestructura antigua eliminada."

# 3. Construir y levantar la nueva version
echo "-> 3. Levantando la nueva infraestructura (construyendo imagen)..."
# --build fuerza la reconstrucción de la imagen (necesario para ver V1.0, V2.0, etc.)
# -d ejecuta en segundo plano
docker-compose up -d --build

echo "--- 🎉 DESPLIEGUE FINALIZADO CON ÉXITO. Servicios en línea. ---"