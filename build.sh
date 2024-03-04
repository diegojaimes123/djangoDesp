#!/usr/bin/env bash
# Exit on error
set -o errexit

# Modify this line as needed for your package manager (pip, poetry, etc.)
if [ -f /etc/os-release ]; then
  # Instalar las bibliotecas necesarias para libsystemd y libsystemd-journal
   apt-get update
   apt-get install -y libssl-dev libffi-dev
fi

pip install -r requirements.txt

# Convert static asset files
python manage.py collectstatic --no-input

# Apply any outstanding database migrations
python manage.py migrate
