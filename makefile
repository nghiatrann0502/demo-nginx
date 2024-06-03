reverse=nginx-reverse-proxy
ip=nginx-ip
round=nginx-round-robin
weight=nginx-weight
least=nginx-least

build-reverse:
	docker build -t $(reverse) -f dockerfile.reverse .
build-round-robin:
	docker build -t $(round) -f dockerfile.round-robin .
build-ip-hash:
	docker build -t $(ip) -f dockerfile.ip .
build-weighted:
	docker build -t $(weight) -f dockerfile.weight-round-robin .
build-least-connection:
	docker build -t $(least) -f dockerfile.least .

build: build-reverse build-round-robin build-ip-hash build-weighted build-least-connection

run-reverse:
	docker rm -f nginx
	docker run -d --name nginx -p 8080:80 $(reverse) 
	docker ps -a | grep nginx

run-round-robin:
	docker rm -f nginx
	docker run -d --name nginx -p 8080:80 $(round)
	docker ps -a | grep nginx

run-ip:
	docker rm -f nginx
	docker run -d --name nginx -p 8080:80 $(ip)
	docker ps -a | grep nginx

run-weighted:
	docker rm -f nginx
	docker run -d --name nginx -p 8080:80 $(weight)
	docker ps -a | grep nginx

run-least:
	docker rm -f nginx
	docker run -d --name nginx -p 8080:80 $(least)
	docker ps -a | grep nginx

