#! /bin/bash

cp -r . /etc/openvpn/server
mkdir -p /usr/lib/systemd/system

#cp /opt/docker/openvpn@.service /usr/lib/systemd/system/openvpn@.service # NO SE ON VA SI SERVIDOR O HOST DEL DOCKER

systemctl start openvpn-server@server.service

#/bin/bash # DE MOMENT INTERACTIU



