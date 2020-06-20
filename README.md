## This repo contains docker-compose configs used to build latest crystal docker images.

### Project directory layout
    .
    ├── docker                  # Docker-compose configs grouped by sub folders
    │   ├── alpine              # alpine based image config files
    │   ├── debian              # debian based image config files
    │   └── ubuntu              # ubuntu based image config files
    ├── LICENSE
    └── README.md

### How to build
Change into folder `docker`
Run below command to build all images:
```bash
docker-compose build
```
You can build a specific image by passing the distro name to `docker-compose build` command:
```bash
docker-compose build alpine
docker-compose build debian
docker-compose build ubuntu
```
Check `docker/docker-compose.yml` for config details.
You can tweak file `docker/.env` to change base image versions.
