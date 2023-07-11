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
RUN wget -qO /tmp/imageio-2.4.1.tar.gz https://files.pythonhosted.org/packages/07/77/0a7d8db71a4c1f9e0ab3e307fd0182e4802c5c9ed187879f987e6048c548/imageio-2.4.1.tar.gz \
    && tar -xzf /tmp/imageio-2.4.1.tar.gz -C /tmp \
    && cd /tmp/imageio-2.4.1 \
    && python setup.py install \
    && cd / \
    && rm -rf /tmp/imageio-2.4.1 /tmp/imageio-2.4.1.tar.gz
RUN rm -rf /notebooks/*
ADD *.ipynb /notebooks/
WORKDIR /notebooks
CMD ["/run_jupyter.sh", "--allow-root"]
