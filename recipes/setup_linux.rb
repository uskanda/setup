# Now this recipe is only supported for Ubuntu.
execute "apt-get-update" do
  command "apt-get update"
  only_if "exit $(( `stat -c %Y /var/lib/apt/lists` > (`date +%s` - 86400) ))"
end

packages = %w[vim]
packages.each do |package_name|
  package package_name do
    action :install
  end
end

