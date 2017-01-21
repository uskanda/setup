#!/bin/bash
while getopts d OPT
do
  case $OPT in
    "d" ) MITAMAE_OPTS="-l debug" ;;
  esac
done

cd $(dirname $0)

bin/install-mitamae

#execute itamae
if [ "$(uname)" == 'Darwin' ]; then
  bin/mitamae local recipes/setup_macos.rb -y nodes/macos.yml $MITAMAE_OPTS
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  bin/mitamae local recipes/setup_linux.rb -y nodes/linux.yml $MITAMAE_OPTS
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
