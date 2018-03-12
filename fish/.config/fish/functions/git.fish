# Defined in /var/folders/b3/bc9plyg11839hf5p3fwyv7qw0000gn/T//fish.9r6q7E/git.fish @ line 2
function git --description 'alias git=hub'
	complete -c git -w hub
    hub  $argv;
end
