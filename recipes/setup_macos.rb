include_recipe './homebrew.rb'
include_recipe './homeshick.rb'

login_shell = node["login_shell"]
unless ENV["SHELL"] == login_shell then
    execute "add login shell to /etc/shells" do
        user "root"
        command "echo '#{login_shell}' >> /etc/shells"
        not_if "grep -q '#{login_shell}' /etc/shells"
    end
    execute "change login shell" do
        command "chsh -s #{login_shell}"
        not_if "env | grep -i 'SHELL' | grep -q '#{login_shell}'"
    end
end

