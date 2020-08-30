#!/bin/sh


docker image build --rm -t ubivis/colab-local:tf_1.15 . -f research/object_detection/dockerfiles/tf1/Dockerfile

