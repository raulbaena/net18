#TCP-Wrappers
Xinted:new internet daemon, escolta en determinats ports en nom del servdor
serveix per estalbiar recursos
Login port 23 (Telnet)
Multi:hread Escolta moltes peticions a l'hota
Sigle:hread --> Es dispara un proces y el sol aten totes les conexions
Multi:hread --> Es disparen procesos diferents que es tanquen quan acaben les peticions

#Hem creat un host net18 y hem copiat tots els arxius de k18:sshd
```
[isx53320159@i12 net18]$ mkdir net18:nethost
[isx53320159@i12 net18]$ ls
net18:nethost  README.md
[isx53320159@i12 net18]$ cd net18\:nethost/
[isx53320159@i12 net18:nethost]$ ls
[isx53320159@i12 net18:nethost]$ cp ../../
apunts.md  net18/     
[isx53320159@i12 net18:nethost]$ cp ../../../k18/
docker-compose/ k18:khost/      k18:khostpam/   k18:kserver/    k18:serverV2/   README.md       
.git/           k18:khostp/     k18:khostpl/    k18:serverbase/ k18:sshd/       
[isx53320159@i12 net18:nethost]$ cp ../../../k18/
docker-compose/ k18:khost/      k18:khostpam/   k18:kserver/    k18:serverV2/   README.md       
.git/           k18:khostp/     k18:khostpl/    k18:serverbase/ k18:sshd/       
[isx53320159@i12 net18:nethost]$ cp ../../../k18/k18:sshd/* .
[isx53320159@i12 net18:nethost]$ ls
```
#Hem creat una imatge anomenada raulbaena/net18:nethost, avui dia utilitzem targets no run levels


#Una vegada dins de la maquina executem el xinetd
	--dontfork 
	/usr/sbin/xinetd -stayalive -pidfile /var/run/xinetd.pid
#Quitem el disble de aquest serveis y el recarreguem
[root@nethost xinetd.d]# vi daytime-stream 
[root@nethost xinetd.d]# vi daytime-dgram  
[root@nethost xinetd.d]# vi echo-stream   
[root@nethost xinetd.d]# vi echo-dgram  
[root@nethost xinetd.d]# vi chargen-stream 
[root@nethost xinetd.d]# vi chargen-dgram  


#Y ens copiem els fitxers del docker a la carpeta del nethost
```
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/daytime-stream .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/daytime-dgram .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/echo-stream .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/echo-dgram .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/chargen-dgram .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/chargen-strem .
Error: No such container:path: nethost:/etc/xinetd.d/chargen-strem
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/chargen-stream .
[isx53320159@i12 net18:nethost]$ 
```

#Comprovem que els ports del docker funcionan
```
Starting Nmap 7.60 ( https://nmap.org ) at 2019-03-06 10:40 CET
Nmap scan report for 172.20.0.2
Host is up (0.00022s latency).
Not shown: 997 closed ports
PORT   STATE SERVICE
7/tcp  open  echo
13/tcp open  daytime
19/tcp open  chargen

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds
```
#En el docker activem el pop y el imap
```
[root@nethost docker]# vi /etc/xinetd.d/imap
[root@nethost docker]# vi /etc/xinetd.d/imaps
[root@nethost docker]# vi /etc/xinetd.d/imap
[root@nethost docker]# ls
Dockerfile  README.md  install.sh  krb5.keytab  startup.sh
[root@nethost docker]# vi /etc/xinetd.d/pop3s 
[root@nethost docker]# vi /etc/xinetd.d/pop3  
[root@nethost docker]# vi /etc/xinetd.d/    
chargen-dgram   daytime-dgram   discard-dgram   echo-dgram      imap            ipop2           pop3s           time-dgram      
chargen-stream  daytime-stream  discard-stream  echo-stream     imaps           ipop3           tcpmux-server   time-stream     
[root@nethost docker]# vi /etc/xinetd.d/ipop3
```

# Ens els copiem al fitxer del docker
```
[isx53320159@i12 net18:nethost]$ vim Dockerfile 
[isx53320159@i12 net18:nethost]$ vim Dockerfile 
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/imap .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/imaps .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/ipop3 .
[isx53320159@i12 net18:nethost]$ docker cp nethost:/etc/xinetd.d/pop3s .
```
#ELs reniniciem els serveis anteriorment editat
```
[root@nethost docker]# ps ax   
  PID TTY      STAT   TIME COMMAND
    1 pts/0    Ss     0:00 /bin/bash
   31 pts/0    S+     0:00 /usr/sbin/xinetd -dontfork
   32 pts/1    Ss     0:00 /bin/bash
   93 pts/1    R+     0:00 ps ax
[root@nethost docker]# kill -1 31
[root@nethost docker]# nmap localhost

Starting Nmap 7.60 ( https://nmap.org ) at 2019-03-06 09:47 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000024s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 993 closed ports
PORT    STATE SERVICE
7/tcp   open  echo
13/tcp  open  daytime
19/tcp  open  chargen
110/tcp open  pop3
143/tcp open  imap
993/tcp open  imaps
995/tcp open  pop3s

Nmap done: 1 IP address (1 host up) scanned in 1.64 seconds
```
#COmprovem que el servei pop funciona
[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 110
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.
+OK POP3 nethost 2007f.104 server ready
STAT
-ERR Unknown AUTHORIZATION state command
popstat
-ERR Unknown AUTHORIZATION state command
user
-ERR Missing username argument
 USER user01
+OK User name accepted, password please
PASS user01
+OK Mailbox open, 0 messages
STAT
+OK 0 0
LIST
+OK Mailbox scan listing follows
.
QUIT
+OK Sayonara
Connection closed by foreign host.

#Comprovem que funciona imap
[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 143
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.
* OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ SASL-IR LOGIN-REFERRALS STARTTLS] nethost IMAP4rev1 2007f.404 at Wed, 6 Mar 2019 10:24:05 +0000 (UTC)
a001 login user01 user01
a001 OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ IDLE UIDPLUS NAMESPACE CHILDREN MAILBOX-REFERRALS BINARY UNSELECT ESEARCH WITHIN SCAN SORT THREAD=REFERENCES THREAD=ORDEREDSUBJECT MULTIAPPEND] User user01 authenticated
a002 select inbox
* 0 EXISTS
* 0 RECENT
* OK [UIDVALIDITY 1551867879] UID validity status
* OK [UIDNEXT 1] Predicted next UID
* FLAGS (\Answered \Flagged \Deleted \Draft \Seen)
* OK [PERMANENTFLAGS ()] Permanent flags
a002 OK [READ-WRITE] SELECT completed
a003 logout
* BYE nethost IMAP4rev1 server terminating connection
a003 OK LOGOUT completed
Connection closed by foreign host.

#Instalem y configurem apache

#Obrrim el servei del POP3
service pop3
{
socket_type = stream
wait = no
user = root
server = /usr/sbin/ipop3d --> Es la ruta d'execució
server_args = -s /var/lib/tftpboot --> arguments de la execucio
log_on_success += HOST DURATION --> Que he de guardar quan ha anat be la connexio en aquest cas el HOST conectat (client) y la duracio
log_on_failure += HOST --> En cas de que falli nomes guarda el host
disable = no --> Aqui posem si volem que estigui o no}
strem tcp----
			|--> socket_type
dgram udp----
raw cru tal com es
wait yes es dispara un y espera a que acabi
wait no es dispara un y quan acabi es tanca
user en nom de qui s'executa el dimoni


instances ---> Determina el numero de servidors que poden estar actius simultaneament
per_source ---> 

only_from
no_access
access_times
redirect

rlimit_as
rlimit_files
rlimit_cpu
rlimit_data
rlimit_rss
rlimit_stack

#Cambiar els valord per defecte xinetd
defaults
{
log_type
= FILE /var/log/servicelog
log_on_success
= PID
log_on_failure
= HOST
only_from
= 128.138.193.0 128.138.204.0
only_from
= 128.138.252.1
instances
= 10
disabled
= rstatd
}


#Exemple redirect
service http-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 80
bind = 0.0.0.0
port = 2080
user = nobody}


Estem obrint el port 2080 y tot el que ens vingui el redirigem a el port 80

#Demonis fets fins ara
al 80
-rw-------. 1 root root 1156 Mar  6 09:33 chargen-dgram
-rw-------. 1 root root 1158 Mar  6 09:32 chargen-stream
-rw-r--r--. 1 root root  163 Mar  6 10:58 daytime-bis
-rw-------. 1 root root 1156 Mar  6 09:32 daytime-dgram
-rw-------. 1 root root 1158 Mar  6 09:32 daytime-stream
-rw-------. 1 root root 1157 Aug  5  2017 discard-dgram
-rw-------. 1 root root 1159 Aug  5  2017 discard-stream
-rw-r--r--. 1 root root  161 Mar  6 10:55 echo-bis
-rw-------. 1 root root 1147 Mar  6 09:32 echo-dgram
-rw-------. 1 root root 1149 Mar  6 09:32 echo-stream
-rw-r--r--. 1 root root  160 Mar  6 10:55 httpd-bis
-rw-r--r--. 1 root root  177 Mar  6 11:00 httpd-tris
-rw-r--r--. 1 root root  369 Mar  6 09:43 imap
-rw-r--r--. 1 root root  364 Mar  6 09:43 imaps
-rw-r--r--. 1 root root  453 Jan 31  2018 ipop2
-rw-r--r--. 1 root root  358 Mar  6 09:44 ipop3
-rw-r--r--. 1 root root  334 Mar  6 09:44 pop3s
-rw-------. 1 root root 1212 Aug  5  2017 tcpmux-server
-rw-------. 1 root root 1149 Aug  5  2017 time-dgram
-rw-------. 1 root root 1150 Aug  5  2017 time-stream

#Reiniciem el xinetd y probem que tot estigui be
[root@nethost xinetd.d]# nmap localhost

Starting Nmap 7.60 ( https://nmap.org ) at 2019-03-06 11:06 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000040s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 990 closed ports
PORT     STATE SERVICE
7/tcp    open  echo
13/tcp   open  daytime
19/tcp   open  chargen
80/tcp   open  http
110/tcp  open  pop3
143/tcp  open  imap
993/tcp  open  imaps
995/tcp  open  pop3s
2007/tcp open  dectalk
2013/tcp open  raid-am
GET / HTTP/1.0 --> Per solicitar una pagina web

#Instances: Per mostrar les instances hem d'enxegar el numero de instancies que permeti
#per_source: Numero maxim d'instancies que poden atendre a un client per a un client
#cps: Pren dos arguments el primer es el nombre de conexions que pot manipular. Si el ratio de conexiones
es mayor que el numero de handles el servei estara temporalment descativat. El segon numero es el temps
que estara abans de reiniciarce despres d'haver estat desactivat.
#max_load: Quin es la carrega mnaxima de connexions que puc acceptar
#only_from: No mes podra accedir el rang de ip o nom de domini que podra conectarse
#no_access: Els que venen de aqui no es podran conectar  
#access_times: A quines hores es poden conectar y a quines hores no es poden conectar els clients
#deny_time: Temps de denegacio del servei

#Exempple de instances
Configurem un serveri
```
service echo-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 7
bind = 0.0.0.0
port = 2007
user = nobody
instences = 2
}
```
#Comprovem el funcionament
```
[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 2007
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.

[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 2007
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.

[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 2007
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.
Connection closed by foreign host.
[isx53320159@i12 net18:nethost]$ 
```
#Exemple only_from
COnfigurem un server
```
service daytime-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 3
bind = 0.0.0.0
port = 2013
user = nobody
only_from = 192.168.2.21
}
```
#Comprovem si funciona
```
[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 2013
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.
Connection closed by foreign host.
```

#Exemple no_access
```
service daytime-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 3
bind = 0.0.0.0
port = 2013
user = nobody
#only_from = 192.168.2.21
no_access = 172.20.0.1
}
```
#Probem
```
[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 2013
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.
Connection closed by foreign host.
```
Hem denegat el servei de docker a la nostre ip de la xarxa docker

#Exemple per_source
```
service echo-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 7
bind = 0.0.0.0
port = 2007
user = nobody
instances = 5
per_source = 1
}
```
#Probem

#Exemple access_times
```
service daytime-tris
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 3
bind = 0.0.0.0
port = 3000
user = nobody
access_times = 08:00-14:00
}
```
```
service daytime-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 3
bind = 0.0.0.0
port = 2013
user = nobody
access_times = 16:00-21:00
}
```

#Exemple log_on_succes
```
service daytime-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = localhost 3
bind = 0.0.0.0
port = 2013
user = nobody
log_on_success += DURATION HOST USERID
}
```
#Probem la conexio
[isx53320159@i12 net18:nethost]$ telnet 172.20.0.2 2013
Trying 172.20.0.2...
Connected to 172.20.0.2.
Escape character is '^]'.
Connection closed by foreign host

#TCP WRAPERS
TCPWRAPERS: Son emboltoris de serveis de xarxa Per als serveis de xarxa que l'utilitzen, els contenidors TCP afegeixen una capa addicional de
protecció definint quins hosts estan o no poden connectar-se a la xarxa "embolicada" serveis

hosts.allow --- This file contains access rules which are used to allow or deny connections
			   |---> FItxers que conytolan el tcpwrapers
hosts.deny----- This file contains access rules which are used to deny connections to network services

#Exmple host deny
```
#
# hosts.deny    This file contains access rules which are used to
#               deny connections to network services that either use
#               the tcp_wrappers library or that have been
#               started through a tcp_wrappers-enabled xinetd.
#
#               The rules in this file can also be set up in
#               /etc/hosts.allow with a 'deny' option instead.
#
#               See 'man 5 hosts_options' and 'man 5 hosts_access'
#               for information on rule syntax.
#               See 'man tcpd' for information on tcp_wrappers
#
xinetd:ALL
```
#Reglas tcpwrapers
1. Si existeix el fitser host.allow. El porcesa es mira la priemra regla
si es pot aplicar la aplica sino continua
2. Si existeix host.deny. El mira si hi ha una regla que fa match s'aplica el deny 
si arriba al final y no fa match permet el servei
	2.1 Com que primer venen els allow tenen preferencia sobre el deny, si allow a aplica el deny no pot denegar-ho
	2.2 L'ordre saplica de dalt abaix
	2.3 Si no hi ha regles en cap dels dos fitxers es permet

#Exmple deny
 [isx53320159@i12 net18:nethost]$ ftp 172.20.0.2
Connected to 172.20.0.2 (172.20.0.2).
421 Service not available.
#Exemple allow
[isx53320159@i12 net18:nethost]$ ftp 172.20.0.2
Connected to 172.20.0.2 (172.20.0.2).
220 (vsFTPd 3.0.3)
Name (172.20.0.2:isx53320159): anonymous
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> 


#Serveis allows exempte una ip
#
# hosts.allow   This file contains access rules which are used to
#               allow or deny connections to network services that
#               either use the tcp_wrappers library or that have been
#               started through a tcp_wrappers-enabled xinetd.
#
#               See 'man 5 hosts_options' and 'man 5 hosts_access'
#               for information on rule syntax.
#               See 'man tcpd' for information on tcp_wrappers
#
vsftpd: 172.20.0.1
ipop3d: ALL
imapd: ALL except 172.20.0.1




