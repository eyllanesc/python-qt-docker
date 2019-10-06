# python-qt-docker

```console
docker build --tag=python-qt .
```

```
docker run -it \
	--tty \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix/:/tmp/.X11-unix/ \ 
	--device /dev/dri --device /dev/snd \
	--privileged \
	-v /run/dbus/:/run/dbus/ \
	--group-add $(getent group audio | cut -d: -f3) \
	python-qt:latest
```