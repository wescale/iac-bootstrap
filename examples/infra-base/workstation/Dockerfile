FROM debian:buster

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ARG AWSCLI_VERSION
ARG ANSIBLE_VERSION
ARG JINJA_VERSION
ARG NETADDR_VERSION
ARG BOTO3_VERSION
ARG TF_VERSION
ARG PACKER_VERSION
ARG MYPACKAGE_VERSION


RUN apt-get update \
  && apt-get install -y wget vim sudo htop tree git libssl-dev curl ruby python3 python3-distutils jq python2.7 \
  && wget https://bootstrap.pypa.io/get-pip.py \
  && python3 get-pip.py \
  && pip3 install awscli==${AWSCLI_VERSION} \
  && pip3 install ansible==${ANSIBLE_VERSION} \
  && pip3 install jinja2==${JINJA_VERSION} \
  && pip3 install netaddr==${NETADDR_VERSION} \
  && pip3 install boto3==${BOTO3_VERSION} \
  && pip3 install mypackage_wsc==${MYPACKAGE_VERSION}



RUN wget --quiet "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip" \
  && unzip "terraform_${TF_VERSION}_linux_amd64.zip" \
  && mv terraform /usr/bin

RUN wget --quiet "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" \
  && unzip "packer_${PACKER_VERSION}_linux_amd64.zip" \
  && mv packer /usr/bin

RUN groupadd -r workstation -g 1000 \
  && useradd -u 1000 -r -g workstation workstation
RUN echo "workstation ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/workstation && \
  chmod 0440 /etc/sudoers.d/workstation
RUN mkdir -p /home/workstation/workdir \
  && chown -R workstation:workstation /home/workstation


VOLUME /home/workstation/workdir
WORKDIR /home/workstation/workdir

ENV PATH="/opt/docker:$PATH"

USER workstation

RUN echo 'alias python="python3"' >> ~/.bashrc


