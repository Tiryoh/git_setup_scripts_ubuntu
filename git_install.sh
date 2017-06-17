#!/bin/bash -eu

sudo apt update
sudo apt install -y libevent-dev libncurses5-dev
sudo apt install -y build-essential automake pkg-config

mkdir $HOME/tmp
mkdir -p $HOME/usr/local
cd $HOME/tmp
git clone https://github.com/git/git.git
cd git
git checkout `git tag -l | sort -Vr | head -n1`
make configure
./configure --prefix=$HOME/usr/local
make all doc
make install

grep -F "/usr/local/bin" ~/.bash_profile || grep -F "/usr/local/bin" ~/.bashrc ||
echo "export PATH=\$HOME/usr/local/bin:\$PATH" >> ~/.bashrc
