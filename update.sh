#!/bin/bash
docker stop muttwizard
docker rm muttwizard
docker build -t muttwizard .
docker run -itd \
	--name=muttwizard \
	-e TZ=America/New_York \
	-u 1000:1000 \
	-v $(pwd)/data:/home/user \
	--restart=always \
	muttwizard
