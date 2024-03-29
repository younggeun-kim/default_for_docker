# aws에서 제공하는 lambda base python image 사용
FROM amazon/aws-lambda-python:3.8

# optional : pip update
RUN /var/lang/bin/python3.8 -m pip install --upgrade pip

# Install opencv-python package
RUN pip3 install opencv-python-headless
RUN git clone https://github.com/younggeun-kim/default_for_docker.git

# install packages
RUN pip install -r default_for_docker/requirements.txt
