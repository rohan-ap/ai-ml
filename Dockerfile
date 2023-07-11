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
RUN pip install --upgrade pip==21.1.3
RUN pip install scikit-learn Pillow

# Install dependencies for imageio
RUN apt-get install -y libsm6 libxext6 libxrender-dev

# Download imageio from PyPI and install it
RUN pip install --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org imageio 

RUN rm -rf /notebooks/*
ADD *.ipynb /notebooks/

WORKDIR /notebooks

CMD ["/run_jupyter.sh", "--allow-root"]
