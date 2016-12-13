setopt rcquotes

alias e='vim .'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lsa='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'
alias lf='ls *(.)' #just files
alias ld='ls *(/)' #just directories
alias df='df -kTh'
alias du='du -kh'
alias tj='tar -xvjpf '
alias t='tar xvfz '
alias tz='tar -xvzpf '
alias tb='tar -xvfj '
alias go='gco'
alias glop='git log --pretty=format:''%Cred%H%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'' --abbrev-commit'
alias glt='glop --since=am'
alias gly='glop --since=''1 day ago'''
alias gh='glop -20'
alias grb='git rebase '
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"
alias ber='be rake '
alias bes='be rspec '
alias bec='be rails c '
alias bed='be rails db '

export PATH="$HOME/.rbenv/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_77.jdk/Contents/Home"
export JAVA=$JAVA_HOME
export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cacert.pem

