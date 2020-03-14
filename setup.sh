#!/bin/bash

sudo apt-get update

sudo apt-get install -y build-essential autoconf bison libyaml-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libssl-dev libreadline-dev zlib1g-dev
sudo apt-get install -y git jq python-pip ack-grep

sudo apt-get install -y mysql-server mysql-client libmariadbclient-dev
sudo apt-get install -y redis-server

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

if [[ ! -d ~/.rbenv ]]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi


export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s | sed 's/tara/bionic/')"
if ! grep -q $CLOUD_SDK_REPO /etc/apt/sources.list.d/google-cloud-sdk.list; then
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
fi
sudo apt-get update && sudo apt-get install -y google-cloud-sdk
sudo apt-get install -y kubectl

if [[ ! -d ~/.vim/pack/plugins/start/vim-vue ]]; then
  git clone https://github.com/posva/vim-vue.git ~/.vim/pack/plugins/start/vim-vue
fi

sudo mkdir -p /opt/helm/v2.11.0
if [[ ! -f /opt/helm/v2.11.0/helm ]]; then
  curl https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz -o - | sudo tar -C /opt/helm/v2.11.0 -zx linux-amd64/helm --strip-components 1
fi

sudo mkdir -p /opt/helm/v3.0.2
if [[ ! -f /opt/helm/v3.0.2/helm ]]; then
  curl https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz -o - | sudo tar -C /opt/helm/v3.0.2 -zx linux-amd64/helm --strip-components 1
fi

sudo mkdir -p /opt/terraform/0.11.13
if [[ ! -f /opt/terraform/0.11.13/terraform ]]; then
  curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip \
   && sudo unzip -d /opt/terraform/0.11.13 /tmp/terraform.zip \
   && sudo chmod 0755 /opt/terraform/0.11.13/terraform
fi

sudo mkdir -p /opt/terraform/0.12.18
if [[ ! -f /opt/terraform/0.12.18/terraform ]]; then
  curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip \
   && sudo unzip -d /opt/terraform/0.12.18 /tmp/terraform.zip \
   && sudo chmod 0755 /opt/terraform/0.12.18/terraform
fi

mkdir -p ~/bin

