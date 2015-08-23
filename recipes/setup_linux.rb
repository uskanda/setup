include_recipe './fzf.rb'

node["homesick"]["castles"].each do |castle|
  castle_basename = File.basename(castle)
  execute "Add Castle" do
    command "homesick clone #{castle};\
             homesick symlink #{castle_basename}"
    not_if "homesick list | grep -q '#{castle_basename}'"
  end
end

