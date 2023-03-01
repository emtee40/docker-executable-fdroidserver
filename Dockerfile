FROM registry.gitlab.com/fdroid/fdroidserver:buildserver

COPY signing-key.asc /

RUN gpg --import /signing-key.asc

RUN . /etc/profile.d/bsenv.sh \
	&& git clone --depth 1 https://gitlab.com/fdroid/fdroidserver.git "${fdroidserver}"

# Install additional utilities required by actual builds (list subject to future expansion)
# build-tools 32.0.0 is needed for a good apksigner
RUN . /etc/profile.d/bsenv.sh \
	&& apt-get update && apt-get install --yes \
		patch \
		autoconf libtool pkg-config \
		ant \
	&& echo y | sdkmanager "build-tools;32.0.0" \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/repo"]
WORKDIR /repo

ENTRYPOINT ["sh", "-c", ". /etc/profile.d/bsenv.sh && GRADLE_USER_HOME=${home_vagrant}/.gradle ${fdroidserver}/fdroid \"$@\"", "-s"]
CMD ["--help"]
