FROM registry.gitlab.com/fdroid/ci-images-base

COPY signing-key.asc /

RUN gpg --import /signing-key.asc

RUN git clone --depth 1 https://gitlab.com/fdroid/fdroidserver.git \
    && cd fdroidserver \
    && pip3 install --upgrade babel pip setuptools \
    && pip3 install --no-binary python-vagrant -e . \
    && python3 setup.py compile_catalog build \
    && python3 setup.py install

# Install additional utilities required by actual builds (list subject to future expansion)
RUN apt-get update && apt-get install --yes \
		patch \
		autoconf libtool pkg-config \
		gradle ant \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/repo"]
WORKDIR /repo

ENTRYPOINT ["../fdroidserver/fdroid"]
CMD ["--help"]
