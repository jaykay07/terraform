#!/bin/sh
systemctl enable docker
systemctl start docker
docker run -d -it -p 80:8080 jaykaykay/my_helloworld_image
