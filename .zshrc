### Set variables
#################
export PATH=$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin
export ZSH="$HOME/.oh-my-zsh"
HISTFILE=$HOME/.zhistory
HISTSIZE=100000000
SAVEHIST=100000000
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
ZSH_THEME="junkfood" #( 09/24/25@ 8:37PM )( u0_a246@localhost ):~
plugins=(sudo extract fzf zsh-autosuggestions F-Sy-H git universalarchive poetry docker docker-compose uv)

source $ZSH/oh-my-zsh.sh
[ -f ~/.privrc ] && source ~/.privrc

### Set alias
#############
alias ..="cd .."
alias cd..="cd .."
alias cls="clear"
alias ll="ls -lisa --color=auto"
alias df="df -ahiT --total"
alias mkdir="mkdir -pv"
alias rf="rm -rfv"
alias rm="rm -rfi"
alias userlist="cut -d: -f1 /etc/passwd"
alias free="free -mt"
alias du="du -ach | sort -h"
alias ps="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias wget="wget -c"
alias histg="history | grep"
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias grep='grep --color=auto'
alias myip='curl http://ipecho.net/plain; echo'
alias fp="ping 8.8.8.8"

alias lsd='lazydocker'
alias lzd='lazydocker'
alias pro='proxychains'
alias a='tmux attach -t main || tmux new -s main'
alias b='byobu'

alias ar50='aria2c --seed-time=0 --max-overall-download-limit=50M -Z'
alias ar40='aria2c --seed-time=0 --max-overall-download-limit=40M -Z'
alias ar20='aria2c --seed-time=0 --max-overall-download-limit=20M -Z'
alias ar10='aria2c --seed-time=0 --max-overall-download-limit=10M -Z'
alias  ar5='aria2c --seed-time=0 --max-overall-download-limit=5M -Z'

command -v eza >/dev/null 2>&1 && \
    LS="eza" ARGS="--color=always --group-directories-first --icons always" || LS=ls ARGS=""

alias l="$LS $ARGS"
alias ls="$LS $ARGS -l"          # preferred listing
alias la="$LS $ARGS -al"         # all files and dirs
alias ll="$LS $ARGS -lisname -l" # long format
alias lt="$LS $ARGS -aT"         # tree listing
alias l.="$LS -a | egrep '^\.'"  # show only dotfiles
alias lsl="$LS $ARGS -lhFA | less"
alias ld="$LS $ARGS -ld .*"
alias lS="$LS $ARGS -lh -F --sort=size"
alias lsf="$LS -lh --color=never --group-directories-first | fzy"

sps()     { UP=- sudo python3 ~/socks5server.py 0.0.0.0 43214 ; } # https://ocv.me/dev/socks5server.py
ff()      { find . -type f -iname '*'"$*"'*' -ls ; } # recursive ls in folder
maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/" ; }
makezip() { zip -r "${1%%/}.zip" "$1" ; }
my_ps()   { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
mcd ()    { mkdir -p $1 ; cd $1 ; }

### Set/unset ZSH options
#########################
# setopt NOHUP
# export USE_CCACHE=1
setopt NOTIFY
setopt NO_FLOW_CONTROL
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
# setopt AUTO_LIST
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME
unsetopt BG_NICE
# setopt CORRECT
# setopt HASH_CMDS
setopt MENUCOMPLETE

### Set/unset  shell options
############################
#setopt   notify globdots correct pushdtohome cdablevars autolist
#setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

### Autoload zsh modules when they are referenced
#################################################
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end