# Adobe Connect ngxin frontend

Simple Adobe Connect frontend for ssl offloading and loadbalancing.

## Installation

1. Install docker
2. Pull nginx `docker pull nginx:latest`
3. Clone nginx frontend
4. Run with below command

```
docker run --rm -ti -p 443:443 -p 80:80 -e SP_HOSTNAME=connect-test.nordu.net -e APPSERVERS="test1.nordu.net test2.nordu.net" -v $(pwd):/app nginx /app/entrypoint.sh
```

## Generate selfsigned cert

```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout ssl/connect.test.dk.key -out ssl/connect.test.dk.crt -subj "/C=/ST=/L=/O=/CN=connect.test.dk"
```
