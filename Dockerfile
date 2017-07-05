FROM debian:stretch

ENV ANDROID_HOME=/opt/android-sdk
VOLUME ["/opt/android-sdk"]

RUN printf "path-exclude=/usr/share/locale/*\npath-exclude=/usr/share/man/*\npath-exclude=/usr/share/doc/*\npath-include=/usr/share/doc/*/copyright\n" >/etc/dpkg/dpkg.cfg.d/01_nodoc \
	&& apt-get update \
	&& apt-get -y upgrade \
	&& apt-get -y dist-upgrade \
        && apt-get install -y --no-install-recommends \
		curl \
		git \
		lib32stdc++6 \
		lib32z1 \
		default-jdk-headless \
		python3 \
		python3-yaml \
		unzip \
		wget \
        gcc \
		git \
		gnupg \
		libjpeg-dev \
		libffi-dev \
		libssl-dev \
		make \
		pyflakes3 \
		pylint3 \
		pep8 \
		python3-clint \
		python3-dev \
		python3-git \
		python3-libcloud \
		python3-paramiko \
		python3-pil \
		python3-pip \
		python3-pyasn1 \
		python3-pyasn1-modules \
		python3-requests \
		python3-ruamel.yaml \
		python3-yaml \
		python3-venv \
		rsync \
		ruby \
		zlib1g-dev \
	&& apt-get -y autoremove --purge \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://gitlab.com/fdroid/fdroidserver.git \
    && cd fdroidserver \
    && pip3 install -e . \
    && python3 setup.py install

VOLUME ["/repo"]
WORKDIR /repo

ENTRYPOINT ["fdroid"]
CMD ["--help"]
