#!/bin/sh

cd research/object_detection/dockerfiles/tf1


docker run --rm --init -it \
	--gpus all \
	--name colab-local \
	-p 8888:8888 -p 6006:6006 \
	--cap-add SYS_ADMIN \
	--device /dev/fuse \
	--security-opt apparmor=unconfined \
	--mount type=bind,source="/home/samot/hd/samot/Downloads/docker-tf-gpu-jupyter/our_project/models/data/",target="/usr/local/lib/python3.6/dist-packages/tensorflow/models/data" \
	--mount type=bind,source="/home/samot/hd/samot/Downloads/docker-tf-gpu-jupyter/our_project/models/modelname/",target="/usr/local/lib/python3.6/dist-packages/tensorflow/models/model" \
	--mount type=bind,source="/home/samot/hd/samot/Downloads/docker-tf-gpu-jupyter/our_project/models/annotations/",target="/usr/local/lib/python3.6/dist-packages/tensorflow/models/annotations" \
	--mount type=bind,source="/home/samot/hd/samot/Downloads/docker-tf-gpu-jupyter/dataset/ColorImages/",target="/usr/local/lib/python3.6/dist-packages/tensorflow/models/images" \
	--mount type=bind,source="/home/samot/hd/samot/Downloads/docker-tf-gpu-jupyter/dataset/Annotations/",target="/usr/local/lib/python3.6/dist-packages/tensorflow/models/annotations/xmls" \
	ubivis/colab-local:tf_1.15 
	

