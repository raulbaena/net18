#! /bin/bash
echo "hola" > /var/www/html/index.html
useradd -g users user01
useradd -g users user02
useradd -g users user03
echo "user01" | passwd --stdin user01
echo "user02" | passwd --stdin user02
echo "user03" | passwd --stdin user03
#Fer un tar i el expandiran amb add
cp /opt/docker/chargen-dgram  /etc/xinetd.d/
cp /opt/docker/chargen-stream /etc/xinetd.d/
cp /opt/docker/daytime-bis    /etc/xinetd.d/
cp /opt/docker/daytime-dgram  /etc/xinetd.d/
cp /opt/docker/daytime-stream /etc/xinetd.d/
cp /opt/docker/Dockerfile     /etc/xinetd.d/
cp /opt/docker/echo-bis       /etc/xinetd.d/
cp /opt/docker/echo-dgram     /etc/xinetd.d/
cp /opt/docker/echo-stream    /etc/xinetd.d/
cp /opt/docker/httpd-bis      /etc/xinetd.d/
cp /opt/docker/httpd-tris     /etc/xinetd.d/
cp /opt/docker/imap	   /etc/xinetd.d/
cp /opt/docker/imaps   /etc/xinetd.d/
cp /opt/docker/ipop3   /etc/xinetd.d/
cp /opt/docker/pop3s   /etc/xinetd.d/
echo "Benvingut a VSTFPD" > /var/ftp/hola.pdf
echo "Access a tothom" > /var/ftp/pub/info.tx
