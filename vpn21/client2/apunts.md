* **Generem clau privada simple per el client:**
```
openssl  genrsa -out clientkey.2vpn.pem
```

**Amb la clau privada, signem el 'request' i generem el fitxer 'clientreq.vpn.pem':**
```
openssl req -new -key clientkey.2vpn.pem -out clientreq.2vpn.pem
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
Organizational Unit Name (eg, section) []:client2
Common Name (e.g. server FQDN or YOUR name) []:client2.edt.org
Email Address []:client2@edt.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:jupiter
An optional company name []:client2
```

**Com a CA, agafem el 'request' generat previament i signarem utilitzant el fitxer d'extensions de client:**
```
openssl x509 -CAkey ../cakey.pem -CA ../cacert.pem -req -in clientreq.2vpn.pem -days 3650 -CAcreateserial -extfile ../server/ext.client.conf -out clientcert.2vpn.pem
Signature ok
subject=C = CA, ST = Barcelona, L = bcn, O = edt, OU = client2, CN = client2.edt.org, emailAddress = client2@edt.org
Getting CA Private Key
```

**Creem network i inicialitzem docker:**
```
docker network  create net_client2
docker run --rm --name client2.edt.org -h client2.edt.org --net net_client2 -it rubeeenrg/tls21:client2 /bin/bash
```
