# BEGIN MANAGED EXPORT BLOCK
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
#PATH=$(brew --prefix findutils)/libexec/gnubin:$PATH
MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
#MANPATH=$(brew --prefix findutils)/libexec/gnuman:$MANPATH
export PATH
export MANPATH
export VAULT_ADDR=https://vault.eng.appianci.net

load_nvm() {
  export NVM_DIR=~/.nvm
  . /usr/local/opt/nvm/nvm.sh
}

node() {
  unset -f node
  [ -z "$NVM_BIN" ] && load_nvm
  node $@
}

npm() {
  unset -f npm
  [ -z "$NVM_BIN" ] && load_nvm
  npm $@
}

npx() {
  unset -f npx
  [ -z "$NVM_BIN" ] && load_nvm
  npx $@
}

yarn() {
  unset -f yarn
  [ -z "$NVM_BIN" ] && load_nvm
  yarn $@
}

nvm() {
  unset -f nvm
  [ -z "$NVM_BIN" ] && load_nvm
  nvm $@
}
# END MANAGED EXPORT BLOCK
# Bindings
bind '"\C-i":complete'
# Aliases
# Git specific
alias fetch='git fetch appian master'
alias status='git status'
alias commit='git commit -m'
alias amend='git commit --amend'
alias push='git push'
alias fpush='git push -f'
alias branches='git branch'
alias remote='git remote -v'
alias config='git --git-dir=$HOME/.my-dotfiles/ --work-tree=$HOME'

# General ones
alias quickmvn='mvn clean install -DskipTests=true'
alias gradlew='./gradlew --console=plain'
# Navigation in PS repo specific
alias aerepo='cd /Users/samrat.jha/appianrepo/ae'
alias fitrepo='cd /Users/samrat.jha/appianrepo/ps-ext-FitNesseForAppian'
alias genrepo='cd /Users/samrat.jha/appianrepo/genesys-cse'
alias twirepo='cd /Users/samrat.jha/appianrepo/twilio-cse'
alias deployment='cd /Users/samrat.jha/appianrepo/ps-ext-DeploymentAutomation/appian-adm-deployment'
alias import='cd /Users/samrat.jha/appianrepo/ps-ext-DeploymentAutomation/appian-adm-import-client'
alias versioning='cd /Users/samrat.jha/appianrepo/ps-ext-DeploymentAutomation/appian-adm-versioning-client'
# Other bash aliases
alias s='. ~/.bash_profile'
alias bashrc='code ~/.bashrc'
alias zshrc='code ~/.zshrc'
alias bashprofile='code ~/.bash_profile'
alias home='cd ~'
alias .1='cd ..'
alias .2='cd ../../'
alias hs='history | grep'

# Tmux aliases
alias tattach='tmux attach -t'
alias tnew='tmux new -s'
alias tkill='tmux kill-session -t'
alias tkillserver='tmux kill-server'


# Functions
assh () {
  ssh -oStrictHostKeyChecking=no -A appian@$1.appianci.net;
}

tailAppServerLog () {
  ssh -oStrictHostKeyChecking=no -A appian@$1.appianci.net tail -f /usr/local/appian/ae/logs/tomcat-stdOut.log
}

function scpPlugin {
  scp $1 appian@$2.appianci.net:/usr/local/appian/ae/_admin/plugins/;
}

function config-auto {
  config add -u
  config commit -a -m "autoupdate `date +%F-%T`"
  config push
}

export PATH=/Users/samrat.jha/.rbenv/bin:/Users/samrat.jha/gems/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/go/bin:/Users/samrat.jha/.rbenv/shims:/usr/local/opt/coreutils/libexec/gnubin:/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/bin:/usr/local/opt/maven@3.2/libexec/bin:/usr/local/go/bin:/Users/samrat.jha/genesys-cse/sonar-scanner-3.3.0.1492-macosx/bin
eval "$(rbenv init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
