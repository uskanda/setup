include_recipe 'homebrew::package'
include_recipe 'homebrew::cask'

#homesick
execute "Install homesick" do
  command "gem install homesick"
  not_if "test $(which homesick)"
end

node["homesick"]["castles"].each do |castle|
  castle_basename = File.basename(castle)
  execute "Add Castle" do
    command "homesick clone #{castle};\
             homesick symlink #{castle_basename}"
    not_if "homesick list | grep -q '#{castle_basename}'"
  end
end

login_shell = node["login_shell"]
execute "add login shell to /etc/shells" do
  user "root"
  command "echo '#{login_shell}' >> /etc/shells"
  not_if "grep -q '#{login_shell}' /etc/shells"
end
execute "change login shell" do
  command "chsh -s #{login_shell}"
  not_if "env | grep -i 'SHELL' | grep -q '#{login_shell}'"
end
