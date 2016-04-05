# PowerDNS-Docker

PowerDNS running on Docker with MySQL backend.


### Build and start services

```
docker-compose stop
docker-compose rm
docker-compose build
docker-compose up
```


### Create the first domain

```
curl -X POST --data '{"name":"example.local", "kind": "Native", "masters": [], "nameservers": ["ns1.example.local", "ns2.example.local"]}' -v -H 'X-API-Key: changeme' $DOCKER_IP/servers/localhost/zones
curl -X PATCH --data '{"rrsets": [ {"name": "example.local", "type": "A", "changetype": "REPLACE", "records": [ {"content": "127.0.0.1", "disabled": false, "name": "example.local", "ttl": 86400, "type": "A", "priority": 0 } ] } ] }' -H 'X-API-Key: changeme' $DOCKER_IP/servers/localhost/zones/example.local
```


### Dig the domain

```
dig example.local @$DOCKER_IP
```


### Docker IP

When using docker-machine, this will come in handy:
```
export DOCKER_IP=$(docker-machine ip)
```
