function set-go
    set -gx GOVERSION $argv[1]
    set -gx GOROOT /Users/xhu/.go/$GOVERSION/goroot
    set -gx GOPATH /Users/xhu/.go/$GOVERSION/gopath
    set -gx PATH $GOROOT/bin $GOPATH/bin $PATH
end
