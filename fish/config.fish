# gvm > /usr/local/etc/dev

alias rmt "rmtrash"
alias vim "nvim"

alias proxy 'export all_proxy=http://127.0.0.1:1087'
alias nasproxy 'export all_proxy=http://192.168.0.101:1087'
alias unproxy 'set --erase all_proxy'

set -gx nvm_default_version v18.2.0

set -x GOROOT /Users/xu.hu/.go/goroot
set -x GOPATH /Users/xu.hu/.go/gopath
set -x GO111MODULE on
set -x GOPROXY https://goproxy.cn,https://goproxy.io,direct
set -x GOSUMDB off

set -gx PATH $GOROOT/bin $GOPATH/bin $PATH

set -gx ACK_GINKGO_RC true

set -gx PATH "$HOME/.cargo/bin" $PATH

set -gx JAVA_HOME /Users/xu.hu/.java/jdk-18.0.1.1.jdk/Contents/Home
set -gx PATH $JAVA_HOME/bin $PATH
set -gx WORKSPACE /Users/xu.hu/Workspace

set -gx MAVEN_HOME /Users/xu.hu/.java/apache-maven-3.8.5
set -gx PATH $MAVEN_HOME/bin $PATH

set -gx GRADLE_USER_HOME /Users/xu.hu/.java/gradle-7.4.2
set -gx PATH $GRADLE_USER_HOME/bin $PATH

set -gx JDTLS_HOME /Users/xu.hu/.java/jdt-language-server-1.10.0-202204131925
set -gx PATH $JDTLS_HOME/bin $PATH
