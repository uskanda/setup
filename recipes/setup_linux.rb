# Now this recipe is only supported for Ubuntu.
execute "apt-get-update" do
  command "apt-get update"
  only_if "exit $(( `stat -c %Y /var/lib/apt/lists` > (`date +%s` - 86400) ))"
end

include_recipe "./homeshick.rb"

%w[minimum source-build].each do |group_name|
  node["group-#{group_name}"]["apt-repositories"] ||= []
  node["group-#{group_name}"]["apt-repositories"].each do |repo_name|
    execute "add apt repository #{repo_name}" do
      command "add-apt-repository #{repo_name}; apt-get update"
      not_if "ls /etc/apt/sources.list.d | grep -q #{repo_name.match(/:(.*)\//)[1]}"
    end
  end
  node["group-#{group_name}"]["packages"].each do |package_name|
    package package_name do
      action :install
    end
  end
end

include_recipe "./fzf.rb"

execute "Change login shell to Zsh (PLEASE TYPE YOUR PASSWORD)" do
  command "chsh -s `which zsh`"
  not_if "echo $SHELL | grep -q zsh"
end

