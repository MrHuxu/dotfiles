# gvm > /usr/local/etc/dev

# alias
alias rmt trash
alias vim nvim
alias cat bat
alias icat "kitty +kitten icat"

alias proxy 'export all_proxy=http://127.0.0.1:1087'
alias nasproxy 'export all_proxy=http://192.168.0.101:1087'
alias unproxy 'set --erase all_proxy'

alias fvim 'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
alias fcat 'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs bat'
alias fcode 'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs code'

# node.js related configs
set -gx nvm_default_version v18.2.0

# golang related configs
set -x GOROOT /Users/xhu/.go/goroot
set -x GOPATH /Users/xhu/.go/gopath
set -x GO111MODULE on
set -x GOPROXY https://goproxy.cn,https://goproxy.io,direct
set -x GOSUMDB off
set -gx PATH $GOROOT/bin $GOPATH/bin $PATH
set -gx ACK_GINKGO_RC true

# rust related configs
set -gx PATH "$HOME/.cargo/bin" $PATH

# java related configs
set -gx JAVA_HOME /Users/xhu/.java/jdk-11.0.15+10/Contents/Home
set -gx PATH $JAVA_HOME/bin $PATH
set -gx WORKSPACE /Users/xu.hu/Workspace

set -gx MAVEN_HOME /Users/xu.hu/.java/apache-maven-3.8.5
set -gx PATH $MAVEN_HOME/bin $PATH

set -gx GRADLE_USER_HOME /Users/xhu/.java/gradle-6.4.1
set -gx PATH $GRADLE_USER_HOME/bin $PATH

set -gx JDTLS_HOME /Users/xhu/.java/jdt-language-server-1.14.0-202207211651
set -gx PATH $JDTLS_HOME/bin $PATH

set -gx SCALA_HOME /Users/xhu/.scala/scala-2.11.12
set -gx PATH $SCALA_HOME/bin $PATH

# fish extension configs
set -Ux fish_tmux_autostart false
set -Ux fish_tmux_autostart_once false
set -Ux fish_tmux_autoconnect false
