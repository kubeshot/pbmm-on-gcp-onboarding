FROM debian:stretch

RUN apt-get update && apt-get install -y apt-transport-https gnupg curl lsb-release unzip jq wget git

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "cloud SDK repo: $CLOUD_SDK_REPO" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update -y && apt-get install google-cloud-sdk -y


# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/1.2.8/terraform_1.2.8_linux_amd64.zip

# Unzip
RUN unzip terraform_1.2.8_linux_amd64.zip

# Move to local bin
RUN mv terraform /usr/local/bin/
CMD ["sh","/workspace/PBMM/docker-startup.sh"]
