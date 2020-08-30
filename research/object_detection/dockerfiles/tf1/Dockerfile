FROM tensorflow/tensorflow:1.15.2-gpu-py3-jupyter

EXPOSE 8888
EXPOSE 6006

ENV CONTENT_PATH=/home/tensorflow
ENV MODELS_PATH=/usr/local/lib/python3.6/dist-packages/tensorflow/models
ENV IMAGES_PATH=$MODELS_PATH/images
ENV ANNOTATIONS_PATH=$MODELS_PATH/annotations
ENV XMLS_PATH=$MODELS_PATH/annotations/xmls
ENV CHECKPOINTS_PATH=$MODELS_PATH/checkpoints
ENV TFREC_PATH=$MODELS_PATH/tf_record
ENV TRAIN_PATH=$MODELS_PATH/train
ENV EVAL_PATH=$MODELS_PATH/eval
ENV DATA_PATH=$MODELS_PATH/data

ARG DEBIAN_FRONTEND=noninteractive

# Install apt dependencies
RUN apt-get update && apt-get install -y \
    git \
    gpg-agent \
    python3-cairocffi \
    protobuf-compiler \
    python3-pil \
    python3-lxml \
    python3-tk \
    wget

# Install gcloud and gsutil commands
# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# Add new user to avoid running as root
RUN useradd -ms /bin/bash tensorflow
USER tensorflow
WORKDIR /home/tensorflow

# Install pip dependencies
RUN pip3 install --user absl-py
RUN pip3 install --user contextlib2
RUN pip3 install --user Cython
RUN pip3 install --user jupyter
RUN pip3 install --user matplotlib
RUN pip3 install --user pycocotools
RUN pip3 install --user tf-slim
RUN pip3 install --user jupyter_http_over_ws
RUN pip3 install --user sklearn

# Copy this version of of the model garden into the image
COPY --chown=tensorflow . /home/tensorflow/models

# Compile protobuf configs
RUN (cd /home/tensorflow/models/research/ && protoc object_detection/protos/*.proto --python_out=.)

ENV PYTHONPATH $PYTHONPATH:/home/tensorflow/models/research/:/home/tensorflow/models/research/slim
ENV TF_CPP_MIN_LOG_LEVEL 3

RUN ["jupyter", "serverextension", "enable", "--py", "jupyter_http_over_ws"]
ENTRYPOINT ["jupyter", "notebook", "--NotebookApp.allow_origin='https://colab.research.google.com'", "--port=8888", "--NotebookApp.port_retries=0", "--notebook-dir=/home/tensorflow", "--ip=0.0.0.0", "--allow-root"]

