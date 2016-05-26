#!/bin/bash
set -ex
# Install the additional tools for reviews.
HOME=/home/ubuntu

sudo apt-get update -qq --fix-missing -y
sudo apt-get install -qy build-essential \
  charm-tools \
  cython \
  git \ 
  make \
  python-dev \
  python-pip \
  python-virtualenv \
  rsync \
  unzip 

sudo pip install --upgrade pip
sudo pip install --upgrade bundletester flake8 pyyaml tox


# Fix for CI choking on duplicate hosts if the host key has changed
# which is common. 
mkdir -p $HOME/.ssh
echo 'Host *' > $HOME/.ssh/config
echo '  StrictHostKeyChecking no' >> $HOME/.ssh/config

# Chuck hates this
touch $HOME/.vimrc
echo "alias vim=vi" >> /home/ubuntu/.bashrc

echo "export LAYER_PATH=${HOME}/layers" >> /home/ubuntu/.bashrc
echo "export INTERFACE_PATH=${HOME}/interfaces" >> /home/ubuntu/.bashrc

chown -R ubuntu:ubuntu ${HOME}

