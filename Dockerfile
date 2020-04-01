FROM debian:buster-slim
LABEL Description="Use the Balena CLI to perform actions"

# Install the standalone balena-cli package v11.30.10
RUN apt-get update && apt-get install -y \
    curl \
	unzip 
RUN  cd /opt/ && \
  curl -L https://github.com/balena-io/balena-cli/releases/download/v11.30.10/balena-cli-v11.30.10-linux-x64-standalone.zip  -o balena-cli.zip && \
  unzip balena-cli.zip && \
  ln -s /opt/balena-cli/balena /usr/bin/ && \
  apt-get purge -y \
    curl \
	unzip && \
  apt-get autoremove -y && \
  rm -rf \
    balena-cli.zip \
    /var/lib/apt/lists/*

# Copy entrypoint into `/opt`
COPY entrypoint.sh /opt/entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/opt/entrypoint.sh"]
