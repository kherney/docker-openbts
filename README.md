# OpenBTS docker N210
Docker building over 18.09.3.
WiridLab Resource. OpenBTS components.Ubuntu 16.04 LTS (xenial) with USRP N210.
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

  - [OpenBTS DB SQLite][db] configuration

## Building / Pulling docker image 

Install the dependencies and devDependencies and start the server.
This will create the dillinger image and pull in the necessary dependencies. Be sure to swap out `${package.json.version}` with the actual version of Dillinger.

```sh
$ cd dillinger
$ npm install -d
$ node app
```

## Create/run container


```sh
$ cd dillinger
$ npm install -d
$ node app
```
```sh
docker run -d -p 8000:8080 --restart="always" <youruser>/dillinger:${package.json.version}
```

#### Composer configuration  file 
[openbts_config.yml][yml]
```yml
version: '3'
services:
  openBTS:
    stdin_open: true
    tty: true
    privileged: true
    container_name: openbts
    image: 'openbts-n210:1.0'
    network_mode: host
    volumes:
      - '/openbts_data_g:/etc/OpenBTS'
    ports:
      - "49300:49300"
volumes:
  openbts_data_g:
    driver: local
```
Dillinger is currently extended with the following plugins. Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md][PlDb] |
| Github | [plugins/github/README.md][PlGh] |
| Google Drive | [plugins/googledrive/README.md][PlGd] |
| OneDrive | [plugins/onedrive/README.md][PlOd] |
| Medium | [plugins/medium/README.md][PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |

Once done, run the Docker image and map the port to whatever you wish on your host. In this example, we simply map port 8000 of the host to port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

## Run/stop container
```sh
cd dillinger
docker build -t joemccann/dillinger:${package.json.version} .
```
## Manage container
```sh
$ cd dillinger
$ npm install -d
$ node app
```
### Common commands

```sh
$ cd dillinger
$ npm install -d
$ node app
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
