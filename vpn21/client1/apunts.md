* **Generem clau privada simple per el client:**
```
openssl  genrsa -out clientkey.1vpn.pem
```

**Amb la clau privada, signem el 'request' i generem el fitxer 'clientreq.vpn.pem':**
```
openssl req -new -key clientkey.1vpn.pem -out clientreq.1vpn.pem

You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:CA
State or Province Name (full name) [Some-State]:Barcelona
Locality Name (eg, city) []:bcn
Organization Name (eg, company) [Internet Widgits Pty Ltd]:edt
Organizational Unit Name (eg, section) []:client1
Common Name (e.g. server FQDN or YOUR name) []:client1.edt.org
Email Address []:client1@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:jupiter
An optional company name []:client1
```

**Com a CA, agafem el 'request' generat previament i signarem utilitzant el fitxer d'extensions de client:**
```
openssl x509 -CAkey ../cakey.pem -CA ../cacert.pem -req -in clientreq.1vpn.pem -days 3650 -CAcreateserial -extfile ../server/ext.client.conf -out clientcert.1vpn.pem
Signature ok
subject=C = CA, ST = Barcelona, L = bcn, O = edt, OU = client1, CN = client1.edt.org, emailAddress = client1@edt.org
Getting CA Private Key
```


Ens copiem el fitxer de conf de client (a la ruta on toca) i certificats i clau --> /etc/openvpn/client

A /etc/openvpn/client/client.conf
hem de canviar a manija:

remote IP_AWS port (1143)


**Creem network i inicialitzem docker:**
```
docker build -t balenabalena/vpn21:client1 .
docker network create --subnet=172.20.0.0/16 net1
docker run --rm --name client1.edt.org -h client1.edt.org --net net1 -p 13:13 -it balenabalena/vpn21:client1 

(el /bin/bash no cal pq ja ho fa el startup.sh) 
```

FALTA (NO SE SI CAL TEMA ENRUTAMENT) :
	
 echo 1 > /proc/sys/net/ipv4/ip_forward

---------------------------------------------

**PROVES:**

** TENINT EL PORT daytime (port 13) FUNCIONANT
podem fer probes tipus: 

	CLIENT 1 A CLIENT 2: 

	telnet client2.edt.org 13 
	(hauria de tornar el dia/hora)




