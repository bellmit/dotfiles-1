# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/samrat.jha/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  venv          # virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  exit_code     # Exit code section
  char          # Prompt character
)

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

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
plugins=(git tmux z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
export VAULT_ADDR=https://vault.eng.appianci.net
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
# Add to the path.
if [[ ! $1 =~ /personal/ ]] ; then
   export PATH=~/personal/scripts:$PATH
fi

# Aliases
# Git specific
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

# General ones
alias gradlew='./gradlew --console=plain'

# Navigation in repos
alias aerepo='cd /Users/samrat.jha/repo/ae'
alias genrepo='cd /Users/samrat.jha/repo/ICC/genesys-cse'
alias twirepo='cd /Users/samrat.jha/repo/ICC/twilio-cse'
alias twiservrepo='cd /Users/samrat.jha/repo/ICC/twilio-servlet'
alias twiconnrepo='cd /Users/samrat.jha/repo/ICC/twilio-connected-system'
alias twiplugin='cd /Users/samrat.jha/repo/ICC/twilio-plugins'
alias icc='cd /Users/samrat.jha/repo/ICC'
alias personal='cd /Users/samrat.jha/personal'

# Other aliases
alias zshrc='code ~/.zshrc'
alias home='cd ~'
alias hs='history | grep'
alias dotfiles='/usr/bin/ --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Tmux specific
alias tconf='code ~/.tmux.conf'
alias tattach='tmux attach -t'
alias tnew='tmux new -s'
alias tkill='tmux kill-session -t'
alias tkillserver='tmux kill-server'

# Functions
function assh () {
  ssh -oStrictHostKeyChecking=no -A appian@$1.appianci.net;
}

function tailAppServerLog () {
  ssh -oStrictHostKeyChecking=no -A appian@$1.appianci.net tail -n 50 -f /usr/local/appian/ae/logs/tomcat-stdOut.log
}

function scpPlugin {
  scp -oStrictHostKeyChecking=no $1 appian@$2.appianci.net:/usr/local/appian/ae/_admin/plugins/;
}

function fd {
 local dir
 dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d \
      -print 2> /dev/null | fzf +m) &&
 cd "$dir"
}

function twilioServletDev {
  ~/repo/ae/./gradlew assembleJars;
  scp /Users/samrat.jha/repo/ae/test/one/Plugins/twilioServlets-v1_5.jar appian@$1.appianci.net:/usr/local/appian/ae/_admin/plugins/;
}

function gen-setup {
  vault-login
  unset VAULT_TOKEN && export VAULT_TOKEN=$(get-vault-token --role genesys-user)
}

function gwssh {
  ssh samrat.jha@genesys-windows.eng.appianci.net -N
}

function glssh {
  ssh genesys-engineering.appianci.net
}

function delete-twilio-subaccount {
  curl -X POST https://api.twilio.com/2010-04-01/Accounts/$1.json \
--data-urlencode "Status=closed" \
-u $1:$2
}

function clone {
  prod_git_url=$1
  git clone $prod_git_url
  folder_name=$(echo $prod_git_url | sed -E 's/.*\/(.*).git/\1/')
  cd $folder_name
  git remote rename origin prod
  git remote set-url prod --push no_push
  if [[ $prod_git_url =~ "gitlab.com:appian/prod/" ]] || [[ $prod_git_url =~ "gitlab.appian-stratus.com:appian/prod/" ]]
  then
    dev_git_url=$(echo $prod_git_url | sed 's/prod\//dev\//')
  else
    dev_git_url=$(echo $prod_git_url | sed 's/appian\//samratjha96\//')
  fi
  git remote add dev $dev_git_url
}

function vault-login {
  unset VAULT_TOKEN && unset VAULT_ADDR
  export VAULT_ADDR="https://vault.eng.appianci.net"
  vault token lookup 2> /dev/null
  if [ $? -ne 0 ]; then
    echo -n "enter ldap username: " && \
    read username && \
    vault login -method=ldap username=$username > /dev/null
  fi
}

function unwrap-creds {
  # vault-login
  # unwrapped_token=$(VAULT_TOKEN=$1 vault unwrap -field=token)
  # unset VAULT_TOKEN && export VAULT_TOKEN=$unwrapped_token
  vault read prod.aws/creds/terraform-iam-prod --format=json > aws-creds.json
  export AWS_ACCESS_KEY_ID=$(cat aws-creds.json | jq -r .data.access_key)
  export AWS_SECRET_ACCESS_KEY=$(cat aws-creds.json | jq -r .data.secret_key)
  export AWS_SESSION_TOKEN=$(cat aws-creds.json | jq -r .data.security_token)
  rm -r aws-creds.json
}

function aws-setup {
  if [ "$#" -ne 1 ]; then
    echo "You must specify either one of: dev or sandbox as an argument"
    return
  fi
  vault-login
  if [[ $1 == "dev" ]]; then
    aws_backend="solutions/dev/aws/creds/dev-admin"
    application="solutions-dev-vault-admin"
  elif [[ $1 == "sandbox" ]]; then
    aws_backend="solutions/dev/aws/creds/sandbox-admin"
    application="solutions-dev-vault-admin" 
  else
    echo "You must specify either one of: dev or sandbox as an argument"
    return
  fi
  export VAULT_TOKEN=$(get-vault-token --application "${application}")
  vault read ${aws_backend} --format=json > aws-creds.json
  export AWS_ACCESS_KEY_ID=$(cat aws-creds.json | jq -r .data.access_key)
  export AWS_SECRET_ACCESS_KEY=$(cat aws-creds.json | jq -r .data.secret_key)
  export AWS_SESSION_TOKEN=$(cat aws-creds.json | jq -r .data.security_token)
  rm -r aws-creds.json
}

function aws-sand-admin {
  vault-login
  export VAULT_TOKEN=$(get-vault-token --application solutions-dev-vault-admin)
  vault read solutions/dev/aws/creds/sandbox-admin --format=json > aws-creds.json
  export AWS_ACCESS_KEY_ID=$(cat aws-creds.json | jq -r .data.access_key)
  export AWS_SECRET_ACCESS_KEY=$(cat aws-creds.json | jq -r .data.secret_key)
  export AWS_SESSION_TOKEN=$(cat aws-creds.json | jq -r .data.security_token)
  rm -r aws-creds.json
}

function dotfiles-auto {
  config add -u
  config commit -a -m "autoupdate `date +%F-%T`"
  config push
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/samrat.jha/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/samrat.jha/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/samrat.jha/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/samrat.jha/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'


# Created by `userpath` on 2020-03-16 22:50:17
export PATH="$PATH:/Users/samrat.jha/.local/bin"
