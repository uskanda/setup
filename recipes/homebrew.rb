# This is inspired by https://github.com/fukuiretu/Itamae-plugin-recipe-homebrew
BREW_INSTALL_URL = 'https://raw.githubusercontent.com/Homebrew/install/master/install'

# Install brew
execute "Install brew" do
  command "ruby -e \"$(curl -fsSL #{BREW_INSTALL_URL})\""
  not_if "test $(which brew)"
end

# Update brew
enable_update = node['brew']['enable_update'] ? node['brew']['enable_update'] : false
if enable_update
  execute 'Update brew' do
    command 'brew update'
  end
else
  MItamae.logger.info('Execution skipped Update brew because of not true enable_update')
end

# Upgrade brew
enable_upgrade = node['brew']['enable_upgrade'] ? node['brew']['enable_upgrade'] : false
if enable_upgrade
  execute 'Upgrade brew' do
    command 'brew upgrade'
  end
else
  MItamae.logger.info('Execution skipped Upgrade brew because of not true enable_upgrade')
end

# Add Repository
node['brew']['add_repositories'].each do |repo|
  execute "Add Repository: #{repo}" do
    command "brew tap #{repo}"
    not_if "brew tap | grep -q #{repo}"
  end
end

# Install bin packages
node['brew']['install_packages'].each do |package|
  package_without_options = package.split(/[ \/]/).last
  execute "Install package: #{package_without_options}" do
    command "brew install #{package}"
    not_if "brew list | grep -q '#{package_without_options}$'"
  end
end

execute 'Install brew-cask' do
  command 'brew install caskroom/cask/brew-cask'
  not_if 'brew list | grep -q brew-cask'
end

# Install apps
install_apps = node['brew']['install_apps']
install_apps.each do |app|
  execute "Install application: #{app}" do
    command "brew cask install #{app} --appdir=\'/Applications\'"
    not_if "brew cask list | grep -q #{app}"
  end
end

# Setup alfred
if install_apps.include?(:alfred)
  execute 'Setup alfred' do
    command 'brew cask alfred link'
  end
end
