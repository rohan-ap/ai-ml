FROM tensorflow/tensorflow:1.0.0
LABEL maintainer="Vincent Vanhoucke <vanhoucke@google.com>"

# Pillow needs libjpeg by default as of 3.0.
RUN apt-get update && apt-get install -y --no-install-recommends \
        libjpeg8-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade pip
RUN pip install --upgrade python
RUN pip install scikit-learn Pillow 
RUN pip install --trusted-host pypi.python.org imageio==2.4.1
RUN rm -rf /notebooks/*
ADD *.ipynb /notebooks/
WORKDIR /notebooks
CMD ["/run_jupyter.sh", "--allow-root"]
