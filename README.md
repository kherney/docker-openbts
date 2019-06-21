# OpenBTS docker N210
Docker building over 18.09.3.
WiridLab Resource. OpenBTS components.Ubuntu 16.04 LTS (xenial) with USRP N210.
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

  - [OpenBTS DB SQLite][db] configuration

## Building / Pulling docker image 

In the building way, this will build a image from Dockerfile. If tried to build another image, you must specify a number version, like 1.1 or 2.0  
```sh
$ docker build -t openbts-n210:TAG-VERSION
```
In the pulling way, it will create the openbts image and pull in the necessary dependencies. Be sure to choose out with the actual version of openbts-n210.

```
$ docker pull kherney/openbts-n210::TAG-VERSION
```

## Create/run container
Docker composer is used to running and defining  multi-container. Composer is a nice feature to configure your service service docker applications. This services is configured in a yml file configuration.  

#### Composer configuration  file 
[openbts_config.yml][yml]
```yml
version: '3'
services:
  openBTS:
    stdin_open: true
    tty: true
    privileged: true
    container_name: NAME_CONTAINER
    image: 'NAME_IMAGE'
    network_mode: host
    volumes:
      - '/NAMEDIR_PATH_HOST_FILE_SQL_DB_OPENBTS:/etc/OpenBTS'
    ports:
      - "49300:49300"
volumes:
  NAME_DIR:
    driver: local
```
The yml file is currently builded with the following commands. Instructions on how to use them in your own application are linked below.

| Command | Description |
| ------ | ------ |
| stdin_open | [plugins/dropbox/README.md][PlDb] |
| tty | [plugins/github/README.md][PlGh] |
| privileged | [plugins/googledrive/README.md][PlGd] |
| container_name | [plugins/onedrive/README.md][PlOd] |
| image | [plugins/medium/README.md][PlMe] |
| network_mode | [plugins/googleanalytics/README.md][PlGa] |
| vulumes | [plugins/googleanalytics/README.md][PlGa] |
| ports | [plugins/googleanalytics/README.md][PlGa] |

After compose your yml configuration, you must  path your yml file with docker-compose command.
```sh
$ 
$ docker-compose  -f YOUR_CONF_FILE.yml up -d
```
This command is another way to create/run a container from iamge. Don't care the way, the result is the same. 
```sh
docker run -d -p 8000:8080 --restart="always" <youruser>/dillinger:${package.json.version}
```
Once done, the container created take the network host. (or whatever open port on the host, also this ports will be exposed in the container). By default, openbts not runs once you launch the container. You must run it manually. 

## Initial OpenBTS configuration

When OpenBTS is launched, it creates a sql DBs in /etc/OpenBTS. If this files exists, OpenBTS run over these files configuration. For this reason we launch OpenBTS manually.  

```sh
cd dillinger
docker build -t joemccann/dillinger:${package.json.version} .
```

## Common commands

### Run/stop container

```sh
$ docker stop NAME_CONATINER
$ docker run NAME_CONTAINER
```


```sh
$ docker exec -it openbts /bin/bash
$ cp -r /openbts_data/. /openbts_data_g
$ docker build -t openbts-n210:1.0 
$ docker container rm openbts-docker
```

## Authors and Contributors

Authors:
- @kherney [GitHub](https://github.com/kherney) & [GitLab](https://gitlab.com/kherney)
- @lealarcon [GitHub](https://github.com/lealarcon) & [GitLab](https://gitlab.com/lealarcon)

# License

This is part of [WiridLab][wiridlab] project. [Wiridlab][web-wirid] is a Research-Lab from GISSIC research group. 
WiridLab - GISSIC -Telecom engineering -Militar Nueva Granda University


   [bts]:       <https://hub.docker.com/r/kherney/openbts-n210>
   [db]:        <>
   [wiridlab]:  <https://gitlab.com/wirid-lab>
   [web-wirid]: <http://wirid-lab.umng.edu.co/?lang=en>
   [yml]:       <https://github.com/kherney/docker-openbts-fullest/blob/master/openbts-config.yml>
