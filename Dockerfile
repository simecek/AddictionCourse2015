FROM crosbymichael/butterfly
MAINTAINER Kwangbom "KB" Choi <kb.choi@jax.org>

# System packages 
RUN apt-get update && apt-get install -y \
    gcc-4.9 \
    g++-4.9 \
    git \
    wget \
    python \
    python-dev \
    python-pip \
    libhdf5-serial-dev \
    sqlite3 \
    libsqlite3-dev \
    python-numpy \
    python-tables \
#    python-scipy \
    gfortran \
    libblas-dev \
    libatlas-dev \
    liblapack-dev \
    ipython \
    ipython3 

# Python packages from conda
RUN pip install biopython==1.63
RUN pip install pysam
RUN pip install bx-python
RUN pip install pytabix
RUN pip install pysqlite
RUN cd /opt && \
    git clone https://github.com/churchill-lab/g2gtools.git && \
    cd g2gtools && \
    python setup.py install

# Install kallisto and kallisto-align
RUN cd /opt && \
    wget http://www.cmake.org/files/v3.2/cmake-3.2.3-Linux-x86_64.tar.gz && \
    tar xvzf cmake-3.2.3-Linux-x86_64.tar.gz && \
    git clone https://github.com/churchill-lab/kallisto-align.git && \
    cd kallisto-align && \
    mkdir build && \
    cd build && \
    /opt/cmake-3.2.3-Linux-x86_64/bin/cmake .. && \
    make && \
    ln -s $(pwd)/kallisto-align  /usr/local/bin/kallisto-align && \
    ln -s $(pwd)/external/src/kallisto-build/src/kallisto /usr/local/bin/kallisto && \
    rm /opt/cmake-3.2.3-Linux-x86_64.tar.gz

# Install emase (python prototype)
RUN pip install scipy==0.13.3
RUN pip install emase

# Install emase-zero
RUN cd /opt && \
    git clone https://github.com/churchill-lab/emase-zero.git && \
    cd emase-zero/src && \
    make && \
    ln -s $(pwd)/emase-zero /usr/local/bin/emase-zero

# Setup application
EXPOSE 8080
