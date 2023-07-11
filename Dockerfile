FROM tensorflow/tensorflow:1.0.0

LABEL maintainer="Vincent Vanhoucke <vanhoucke@google.com>"

# Pillow needs libjpeg by default as of 3.0.
RUN apt-get update && apt-get install -y --no-install-recommends \
        libjpeg8-dev \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN apt-get install -y wget 
RUN pip install --upgrade pip
RUN pip install scikit-learn Pillow

# Download imageio from PyPI and install it from a local source
RUN pip install imageio 

RUN rm -rf /notebooks/*
ADD *.ipynb /notebooks/

WORKDIR /notebooks

CMD ["/run_jupyter.sh", "--allow-root"]
