VER=0.2
build:
	docker build . -t asdlfkj31h/debian-novnc:${VER} -t debian-novnc:${VER} -t asdlfkj31h/debian-novnc:latest

push:
	docker push asdlfkj31h/debian-novnc:${VER}
	docker push asdlfkj31h/debian-novnc:latest
