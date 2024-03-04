#!/usr/bin/env bash
# Exit on error
set -o errexit

# Modify this line as needed for your package manager (pip, poetry, etc.)
if [ -f /etc/os-release ]; then
  # Crear un directorio temporal para las listas de paquetes
  mkdir -p /tmp/lists/partial
  mkdir -p /var/lib/apt/lists/partial

  # Actualizar y luego instalar las bibliotecas necesarias para libsystemd y libsystemd-journal
  apt-get update
  apt-get install -y libssl-dev libffi-dev

  # Eliminar el directorio temporal
  rm -rf /tmp/lists
fi

pip install -r requirements.txt

# Convert static asset files
python manage.py collectstatic --no-input

# Apply any outstanding database migrations
python manage.py migrate
