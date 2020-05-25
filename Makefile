VER=0.2
build:
	docker build . -t asdlfkj31h/debian-novnc:${VER} debian-novnc

push:
	docker push asdlfkj31h/debian-novnc:${VER}
