ARG BASE_IMAGE
FROM ${BASE_IMAGE}
ARG IMAGES_DIR=/tmp/oryx/images

RUN apt-get update \
  && apt-get install -y \
    unzip \
  && rm -rf /var/lib/apt/lists/*
  
# NOTE: This is a list of keys for ALL Node versions and also Yarn package installs.
# Receiving them once speeds up building of individual node versions as they all derive
# from this image.

# Gpg keys listed at https://github.com/nodejs/node
RUN ${IMAGES_DIR}/receiveGpgKeys.sh \
    6A010C5166006599AA17F08146C2130DFD2497F5

COPY images/yarn-v1.22.15.tar.gz .

RUN mkdir -p /opt \
  && tar -xzf yarn-v1.22.15.tar.gz -C /opt/ \
  && ln -s /opt/yarn-v1.22.15/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn-v1.22.15/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v1.22.15.tar.gz
