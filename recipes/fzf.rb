# now use homebrew in macos
git "fzf" do
  repository "https://github.com/junegunn/fzf.git"
  destination ENV["HOME"] + "/.fzf"
end

#TODO: not_if conditions
execute "install fzf" do
  command ENV["HOME"] + "/.fzf/install --all"
  not_if "type fzf"
end
