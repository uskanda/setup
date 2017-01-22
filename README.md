Setup script for development environment
============

Installation
------------------

### MacOS

```sh
git clone https://github.com/uskanda/setup/
./install.sh
```

### Linux

```sh
git clone https://github.com/uskanda/setup/
sudo ./install.sh
```

TODO: online install 

Components
-------------------

|Name|Description|
|:----|:----|
| [MItamae](https://github.com/k0kubun/mitamae) | Configuration Management Tool|
| [Homebrew](http://brew.sh/)| MacOS package manager|
| [homeshick](https://github.com/andsens/homeshick)|git dotfiles synchronizer written in bash|
| [dotfiles](https://github.com/uskanda/dotfiles)|My Dotfiles|

Support Platform
------------------
* OS X El Capitan
* Ubuntu 16.04 LTS

Limitations
------------------
* For speeding up, homebrew installation check ("brew tap", "brew list", "brew cask list") runs only once.Depending on package dependencies, installation may not succeed. In that case, please install again.
