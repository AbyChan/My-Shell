source "/home/tyan/bin/zgen"
export PATH=/home/linaro/bin:$PATH
# check if there's no init script

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/history-substring-search
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load tarruda/zsh-autosuggestions
    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/miloshadzic

    # save all to init script
    zgen save
fi


zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
bindkey '^f' end-of-line
bindkey 'End' end-of-line
AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=14'

export TERM=xterm-256color

alias npm=cnpm


export PATH="/home/tyan/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/tyan/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/tyan/USR/android-sdk-linux/tools:/home/tyan/USR/android-sdk-linux/platform-tools"
export ANDROID_HOME="/home/tyan/USR/android-sdk-linux"
export PATH="/home/tyan/.cask/bin:$PATH"


alias emax="emacsclient -t"                      # used to be "emacs -nw"
alias semac="sudo emacsclient -t"                # used to be "sudo emacs -nw"
alias emacsc="emacsclient -c -a emacs"           # new - opens the GUI with alternate non-daemon
alias c-="cd -"
xset b off

[[ -s /home/tyan/.autojump/etc/profile.d/autojump.sh  ]] && source /home/tyan/.autojump/etc/profile.d/autojump.sh


function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi


bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

#fix arrow keys that display A B C D on remote shell
export term=cons25
[[ $TERM == eterm-color  ]] && export TERM=xterm
export EDITOR=vim
export PYTHONPATH=.:$PYTHONPATH
