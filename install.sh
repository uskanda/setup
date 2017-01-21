bin/install-mitamae

#execute itamae
if [ "$(uname)" == 'Darwin' ]; then
  bin/mitamae local recipes/setup_macos.rb -y nodes/local.yml -l debug
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  bin/mitamae local recipes/setup_linux.rb
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
