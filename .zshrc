# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/samrat/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux git z)

source $ZSH/oh-my-zsh.sh
source ~/.profile

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Aliases
alias zshrc="code ~/.zshrc"
alias cat="bat"
alias Github="cd ~/Github"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Git specific aliases
alias fetch='git fetch prod master'
alias status='git status'
alias commit='git commit -m'
alias amend='git commit --amend'
alias push='git push'
alias fpush='git push -f'
alias branches='git branch'
alias remote='git remote -v'
alias logf='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias git-top='pushd $(git rev-parse --show-toplevel) 1> /dev/null'

# Tmux specific
alias tconf='code ~/.tmux.conf'
alias tattach='tmux attach -t'
alias tnew='tmux new -s'
alias tkill='tmux kill-session -t'
alias tkillserver='tmux kill-server'


function dotfiles-auto {
  dotfiles add -p
  dotfiles commit -a -m "autoupdate `date +%F-%T`"
  dotfiles push -u
}

function clone {
  prod_git_url=$1
  git clone $prod_git_url
  folder_name=$(echo $prod_git_url | sed -E 's/.*\/(.*).git/\1/')
  cd $folder_name
  git remote rename origin prod
  git remote set-url prod --push no_push
  if [[ $prod_git_url =~ "gitlab.com:appian/prod/" ]]
  then
    dev_git_url=$(echo $prod_git_url | sed 's/prod\//dev\//')
  else
    dev_git_url=$(echo $prod_git_url | sed 's/appian\//samratjha96\//')
  fi
  git remote add dev $dev_git_url
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$GOPATH/bin:$PATH
