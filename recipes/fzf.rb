git "fzf" do
  repository "https://github.com/junegunn/fzf.git"
  destination ENV["HOME"] + "/.fzf"
end

#TODO: To answer interactive questions automatically like expect
#TODO: not_if conditions
execute "install fzf" do
  command ENV["HOME"] + "/.fzf/install"
end
