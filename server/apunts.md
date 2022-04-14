* **Generem clau privada simple per el servidor:**
```
openssl genrsa -out serverkey.vpn.pem
```

**Amb la clau privada, signem el 'request' i generem el fitxer 'serverreq.vpn.pem':**
```
openssl req -new -key serverkey.vpn.pem -out serverreq.vpn.pem
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
Organizational Unit Name (eg, section) []:vpn
Common Name (e.g. server FQDN or YOUR name) []:vpn.edt.org
Email Address []:vpn@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:jupiter
An optional company name []:vpn
```

**Com a CA, agafem el 'request' generat previament i signarem utilitzant el fitxer d'extensions de servidor:**
```
openssl x509 -CAkey ../cakey.pem -CA ../cacert.pem -req -in serverreq.vpn.pem -days 3650 -CAcreateserial -extfile ext.server.conf -out servercert.vpn.pem
Signature ok
subject=C = CA, ST = Barcelona, L = bcn, O = edt, OU = vpn, CN = vpn.edt.org, emailAddress = vpn@edt.org
Getting CA Private Key
```
**Generem el nostre propi fitxer:**

Generate Diffie-Hellman keys used for key exchange during the TLS handshake between OpenVPN server and the connecting clients.
```
openssl dhparam -out dh2048.pem 2048
```

**Copiem tot el contingut del servidor a l'AWS:**
```
sudo scp -i ~/.ssh/labsuser.pem * admin@54.221.80.230:~
```

**DINS D'AWS...**

**Copiem els arxius a la carpeta corresponent (tant claus com conf servidor):**
```
...:~$ sudo cp * /etc/openvpn/server/
```
