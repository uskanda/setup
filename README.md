Setup script for development environment
============

Installation
------------------

```sh
git clone https://github.com/uskanda/setup/
sudo sh ./install.sh
```

TODO: online install 

Components
-------------------

|Name|Description|
|:----|:----|
| [MItamae](https://github.com/k0kubun/mitamae) | Configuration Management Tool|
| [Homebrew](http://brew.sh/)| MacOS package manager|
| [dotfiles](https://github.com/uskanda/dotfiles)|My Dotfiles|

Support Platform
------------------
* OS X El Capitan

Limitations
------------------
* For speeding up, homebrew installation check ("brew tap", "brew list", "brew cask list") runs only once.Depending on package dependencies, installation may not succeed. In that case, please install again.
