# aws에서 제공하는 lambda base python image 사용
FROM amazon/aws-lambda-python:3.8

# optional : pip update
RUN /var/lang/bin/python3.8 -m pip install --upgrade pip

# install git
RUN yum install git -y
RUN yum -y update && yum -y install \
    gcc \
    gcc-c++ \
    python3-devel \
    cmake \
    make \
    pkg-config \
    libjpeg-devel \
    libpng-devel \
    libtiff-devel \
    libjasper-devel \
    openexr-devel \
    libwebp-devel \
    x264-devel \
    ffmpeg-devel \
    gstreamer-plugins-base-devel \
    gtk2-devel \
    numpy \
    tbb \
    eigen3-devel

# Install OpenCV
WORKDIR /tmp
RUN curl -L https://github.com/opencv/opencv/archive/4.5.4.tar.gz | tar xz \
    && cd opencv-4.5.4 \
    && mkdir build \
    && cd build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
             -D CMAKE_INSTALL_PREFIX=/usr/local \
             -D OPENCV_GENERATE_PKGCONFIG=ON \
             -D BUILD_opencv_python3=ON \
             -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
             .. \
    && make -j $(nproc) \
    && make install \
    && rm -rf /tmp/*

# Install opencv-python package
RUN pip3 install opencv-python-headless
RUN git clone https://github.com/younggeun-kim/default_for_docker.git

# install packages
RUN pip install -r default_for_docker/requirements.txt
