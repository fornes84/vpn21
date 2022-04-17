#! /bin/bash

cp /opt/docker/daytime /etc/xinetd.d/.

/etc/init.d/xinetd start

/bin/bash
