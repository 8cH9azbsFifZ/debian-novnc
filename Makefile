build:
	docker build . -t debian-novnc
	docker build . -t asdlfkj31h/debian-novnc:0.2

push:
	docker push asdlfkj31h/debian-novnc:0.2
