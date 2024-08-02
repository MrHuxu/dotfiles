eval "$(/opt/homebrew/bin/brew shellenv)"

# alias
alias rmt trash
alias vim nvim
alias cat bat
alias icat "kitty +kitten icat"

alias proxy 'export all_proxy=http://127.0.0.1:1087'
alias nasproxy 'export all_proxy=http://192.168.0.117:1082'
alias unproxy 'set --erase all_proxy'

alias fvim 'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
alias fcat 'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs bat'
alias fcode 'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs code'

# node.js related configs
# set -gx nvm_default_version v18.2.0

# golang related configs
set-go 1.20
set -x GO111MODULE on
set -x GOPROXY https://goproxy.io,direct
set -x GOSUMDB off
set -gx ACK_GINKGO_RC true

# rust related configs
set -gx PATH "$HOME/.cargo/bin" $PATH

# fish extension configs
set -Ux fish_tmux_autostart false
set -Ux fish_tmux_autostart_once false
set -Ux fish_tmux_autoconnect false
