#!/bin/sh
# Author Omar Ricardo Vargas Cárdenas <omar.vargas.cardenas at gmail.com>

echo "Instalando el Sistema de Video Distribuido."

echo "Listado de Pasos:"
echo "1. Agregar comando reproducirCarpeta"
echo "2. Agregar Servicio de reproduccion de video"
echo "3. Agregar tareas programadas."

echo "Espere mientras se completan las tareas..."

cp ./reproducirCarpeta /bin/bash
chmod 777 /bin/bash/reproducirCarpeta
echo "paso 1 OK"

cp ./src/svd /etc/init.d/
chmod 755 /etc/init.d/svd
update-rc.d svd defaults
echo "paso 2 OK"

cp ./src/ntp /etc/cron.hourly/

echo '0 22 * * 1-7 /etc/init.d/svd play' >> /etc/crontab
echo '50 6 * * 1-7 /etc/init.d/svd restart' >> /etc/crontab
echo '0 0 * * 1-7 /etc/init.d/svd synchronize' >> /etc/crontab

echo "paso 3 OK"

echo "iniciando sincronización"
/etc/init.d/svd synchronize

echo "reinicie el sistema..."

