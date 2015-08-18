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

