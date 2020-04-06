#!/bin/bash
docker stop muttwizard
docker rm muttwizard
docker build -t muttwizard .
mkdir data
docker run -itd \
	--name=muttwizard \
	-e TZ=America/New_York \
	-u 1000:1000  \
	-v $(pwd)/data:/home/user \
	--restart=always \
	muttwizard
docker exec -it muttwizard /usr/bin/gpg --full-gen-key && \
echo "Enter the GPG email you used (Does not have to be the same as the mutt email)"
read EMAIL
docker exec -it muttwizard /usr/bin/pass init $EMAIL
docker exec -it muttwizard /usr/local/bin/mw add
docker exec -it muttwizard /usr/bin/mbsync -a
docker restart muttwizard
