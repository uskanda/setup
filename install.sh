#!/bin/bash

eval "$(/opt/homebrew/bin/brew shellenv)"
brew -v > /dev/null 2>&1
if [ $? -eq 127 ]; then
    echo "Homebrew is not installed. Install Homebrew...\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Install Homebrew bundles..."
brew bundle
echo "Done."

grep `which fish` /etc/shells
echo "Check Default Shell..."
if [ $? = 0 ]; then
    echo "Default shell is already fish."
else
    echo "Change default shell.."
    echo `which fish` | sudo tee -a /etc/shells
    chsh -s `which fish`
    echo "Done."
fi

echo "Clone Homeshick..."
homeshick clone git@github.com:uskanda/dotfiles.git
echo "Done."

# Write MacOS Defaults
# Enable keyrepeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Todo
# install source-han-code-jp automatically