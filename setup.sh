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

mkdir -p ~/bin

curl https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz -o - | tar -C ~/bin -zx linux-amd64/helm --strip-components 1
curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip \
 && unzip -d ~/bin /tmp/terraform.zip \
 && chmod 0755 ~/bin/terraform


