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
tmpfile=`mktemp`
if node['brew']['add_repositories'] && !node['brew']['add_repositories'].empty? then
  #execute "Make Temporary Brew Tap" do
  #  command "brew tap > #{tmpfile}"
  #end
  system "brew tap > #{tmpfile}"
  node['brew']['add_repositories'].each do |repo|
    execute "Add Repository: #{repo}" do
      command "brew tap #{repo}"
      not_if "grep -q #{repo} #{tmpfile}"
    end
  end
end

# Install bin packages
tmpfile_packages=`mktemp`
if node['brew']['install_packages'] && !node['brew']['install_packages'].empty? then
  system "brew list > #{tmpfile_packages}"
  node['brew']['install_packages'].each do |package|
    package_without_options = package.split(/[ \/]/).last
    execute "Install package: #{package_without_options}" do
      command "brew install #{package}"
      not_if "grep -q '#{package_without_options}$' #{tmpfile_packages}"
    end
  end
end

# Install apps
tmpfile_casks=`mktemp`
install_apps = node['brew']['install_apps']
unless install_apps.empty? then
  system "brew cask list > #{tmpfile_casks}"
  install_apps.each do |app|
    execute "Install application: #{app}" do
      command "brew cask install #{app} --appdir=\'/Applications\'"
      not_if "grep -q #{app} #{tmpfile_casks}"
    end
  end
end

# Setup alfred
if install_apps.include?(:alfred)
  execute 'Setup alfred' do
    command 'brew cask alfred link'
  end
end
