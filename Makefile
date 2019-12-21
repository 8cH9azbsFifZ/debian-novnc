build:
	docker build . -t debian-novnc
	docker build . -t asdlfkj31h/debian-novnc:0.2
	docker build . -t t20:5000/debian-novnc:0.2

push:
	docker push asdlfkj31h/debian-novnc:0.2
	docker push t20:5000/debian-novnc:0.2
