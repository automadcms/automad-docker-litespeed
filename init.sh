#!/bin/sh

set -e

if [ -z "$(ls -A -- "/usr/local/lsws/conf/")" ]; then
	cp -R /usr/local/lsws/.conf/* /usr/local/lsws/conf/
fi

if [ -z "$(ls -A -- "/usr/local/lsws/admin/conf/")" ]; then
	cp -R /usr/local/lsws/admin/.conf/* /usr/local/lsws/admin/conf/
fi

mkdir -p /tmp/automad

if [ ! -d /app/automad ]; then
	composer create-project --no-install --prefer-dist automad/automad /app $AUTOMAD_VERSION
	echo
fi

if [ -n "$UID" ]; then
	CURRENT_UID=$(id -u lsadm 2>/dev/null || echo "")

	if [ "$UID" != "$CURRENT_UID" ]; then
		echo "Updating lsadm UID to $UID ..."
		usermod -u "$UID" lsadm
	fi
fi

chown -R lsadm:lsadm /tmp/automad
chown -R lsadm:lsadm /app
chmod -R 755 /app

chown -R lsadm:lsadm /usr/local/lsws

/usr/local/lsws/bin/lswsctrl start
$@

while true; do
	if ! /usr/local/lsws/bin/lswsctrl status | /usr/bin/grep 'litespeed is running with PID *' >/dev/null; then
		break
	fi
	sleep 60
done
