source "${HOME}/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/chruby
    zgen oh-my-zsh plugins/colored-man
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/knife
    zgen oh-my-zsh plugins/knife_ssh
    zgen oh-my-zsh plugins/osx
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/rsync
    zgen oh-my-zsh plugins/screen
    zgen oh-my-zsh plugins/vagrant
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load chrissicool/zsh-256color


    # completions
    zgen load zsh-users/zsh-completions src
    

    # theme
    zgen oh-my-zsh themes/miloshadzic

    zgen load zsh-users/zsh-history-substring-search
    zgen load tarruda/zsh-autosuggestions

    # Set keystrokes for substring searching
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down


    # save all to init script
    zgen save
fi

bindkey '^f' vi-forward-word
bindkey '^e' vi-end-of-line

zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

alias emax="emacsclient -t"                      # used to be "emacs -nw"
alias semac="sudo emacsclient -t"                # used to be "sudo emacs -nw"
alias emacsc="emacsclient -c -a emacs"           # new - opens the GUI with alternate non-daemon
alias py="python" 
alias ks='ls'
alias rg='ranger'

[[ -s /home/aby/.autojump/etc/profile.d/autojump.sh ]] && source /home/aby/.autojump/etc/profile.d/autojump.sh


export EDITOR=vim
export PATH=~/bin:$PATH


function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}

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
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh  ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


cat() {
    local out colored
    out=$(/bin/cat $@)
    colored=$(echo $out | pygmentize -f console -g 2>/dev/null)
    [[ -n $colored ]] && echo "$colored" || echo "$out"
}

source ~/.mz-components.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PYTHONPATH=.:$PYTHONPATH

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
