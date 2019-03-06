#! /bin/bash
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/httpd && "Apache Iniciat"
/usr/sbin/xinetd -dontfork && echo "Xinetd iniciat"

