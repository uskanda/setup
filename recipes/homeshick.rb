return unless node["homesick"]

home_dir = ENV["HOME"]
homeshick_dir = "#{home_dir}/.homesick/repos/homeshick"
git homeshick_dir do
  repository "git://github.com/andsens/homeshick.git"
end

node["homesick"]["castles"].each do |castle|
  castle_basename = File.basename(castle)
  execute "Add Castle" do
    command "#{homeshick_dir}/bin/homeshick clone #{castle};\
             #{homeshick_dir}/bin/homeshick symlink #{castle_basename}"
    not_if "#{homeshick_dir}/bin/homeshick list | grep -q '#{castle_basename}'"
  end
  execute "Update Castles" do
    command "#{homeshick_dir}/bin/homeshick pull"
    only_if "#{homeshick_dir}/bin/homeshick check | grep -q behind"
  end
end
