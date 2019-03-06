#! /bin/bash
echo "hola" > /var/www/html/index.html
useradd -g users user01
useradd -g users user02
useradd -g users user03

echo "user01" | passwd --stdin user01
echo "user02" | passwd --stdin user02
echo "user03" | passwd --stdin user03


