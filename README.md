# sonarr

an debian based docker build for [sonarr](https://sonarr.tv/)

### build

```
docker build -t pbergman/sonarr .
```

### run 

```
docker run \
	-p 8989:8989 \
	--user $(id -u):$(id -g) \
	-v data:/usr/lib/nzbdrone/config \
  	-v tvseries:/usr/lib/nzbdrone/tv \
  	-v downloads:/usr/lib/nzbdrone/downloads \
	--detach \
	--restart unless-stopped \
	pbergman/sonarr
```