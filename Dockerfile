FROM ubuntu:16.04
RUN apt-get update --fix-missing && apt-get install -y wget apt-transport-https git-core vim curl build-essential python2.7-dev libssl-dev libffi-dev \
	libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev \
	python3-tk libxml2-dev libxslt1-dev supervisor  libfontconfig1 chrpath libxft-dev \
	libmysqlclient-dev python-software-properties software-properties-common libsasl2-dev python3-dev libldap2-dev \
	libfreetype6 libfontconfig1-dev netcat
COPY /code/AtoZ /apps/AtoZ/requirements.txt
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && pip3 install -r /apps/AtoZ/requirements.txt && pip3 install gunicorn pillow
COPY /code/AtoZ /etc/supervisor/conf.d/
COPY /code/AtoZ /apps/AtoZ
RUN	chmod +x /apps/AtoZ/gunstart && mkdir /apps/AtoZ/logs
WORKDIR /apps/AtoZ/
CMD supervisord
