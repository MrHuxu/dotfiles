# gvm > /usr/local/etc/dev

alias rmt "rmtrash"
alias vim "nvim"

alias proxy 'export all_proxy=http://127.0.0.1:1087'
alias nasproxy 'export all_proxy=http://192.168.0.101:1087'
alias unproxy 'set --erase all_proxy'

set -x GOROOT /Users/xhu/.go/goroot
set -x GOPATH /Users/xhu/.go/gopath
set -x GO111MODULE on
set -x GOPROXY https://goproxy.cn,https://goproxy.io,direct
set -x GOSUMDB off

set -gx PATH $GOROOT/bin $GOPATH/bin $PATH

set -gx ACK_GINKGO_RC true

set -gx PATH "$HOME/.cargo/bin" $PATH

set -gx JAVA_HOME /Users/xhu/.java/jdk-18.0.1.jdk/Contents/Home
set -gx PATH $JAVA_HOME/bin $PATH
set -gx WORKSPACE /Users/xhu/Workspace

set -gx MAVEN_HOME /Users/xhu/.java/apache-maven-3.8.5
set -gx PATH $MAVEN_HOME/bin $PATH

set -gx JDTLS_HOME /Users/xhu/.java/jdt-language-server-1.10.0-202204131925
set -gx PATH $JDTLS_HOME/bin $PATH

