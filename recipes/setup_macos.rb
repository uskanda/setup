include_recipe './homebrew.rb'

node["homesick"]["castles"].each do |castle|
  castle_basename = File.basename(castle)
  execute "Add Castle" do
    command "homesick clone #{castle};\
             homesick symlink #{castle_basename}"
    not_if "homesick list | grep -q '#{castle_basename}'"
  end
end

include_recipe './fzf.rb'

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

#TODO: support any version
execute "install ricty fonts" do
  command "cp -f /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf ~/Library/Fonts/;\
           fc-cache -vf"
  not_if "find ~/Library/Fonts/ | grep -q 'Ricty'"
end

#python libraries
#TODO: make python recipe
execute "install powerline" do
  command "pip3 install powerline-status"
  not_if "pip3 list | grep 'powerline-status'"
end
execute "install psutil" do
  command "pip3 install psutil"
  not_if "pip3 list | grep 'psutil'"
end

