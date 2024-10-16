# pylsl-docker

This repository create a docker image to run pylsl with in a docker container which can comunicate with host machine pylsl instance. 

Reason for this is that we can now setup a HIL optimization in a docker container with set environment variables and the same, and run it on the host machine. 


## steps:

1. install docker desktop from https://www.docker.com/products/docker-desktop/ or using snap on ubuntu.

2. Build the docker image:
   1. `docker build -t pylsl-image .`
   2. `docker run -it --rm --network host pylsl-image`


3. Run the pylsl example in the container:
    `python -m pylsl.examples.SendData`


4. In your host machine which has the pylsl installed, run:
    `python -m pylsl.examples.ReceiveData`




