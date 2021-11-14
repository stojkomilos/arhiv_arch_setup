# Environment variables are in ~/.zshenv
# Path variable is in ~/.zshenv

#-------------------------------------------------------------------
#zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-/]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"
#-------------------------------------------------------------------

# Don't prompt for "y/n" when doing "rm foo/*"
setopt rmstarsilent

# NOTE: you CAN still use many emacs(and other) style commands in vim (either modes), e.g. Ctrl+w, Ctrl+d, Ctrl+l

autoload -U colors && colors # For the zsh prompt color code to be human readable

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

setopt SHARE_HISTORY          #TODO: Share history between all sessions.
setopt HIST_VERIFY            #TODO: Do not execute inmediately upon history expansion.

_comp_options+=(globdots) # Include hidden files
stty -ixon # Disable ctrl-s and ctrl-q

export KEYTIMEOUT=1 # Something for vim mode. Does not matter in practice.

# Ctrl+e to edit currently typed command in your choosen text editor ($EDITOR)
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Autocompletion navigation with vim keys(luke smith):
zmodload zsh/complist # Just necessary for things
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-up-line-or-history
bindkey -M menuselect 'k' vi-forward-char
bindkey -M menuselect 'l' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor for different vi modes
#------------------------------------------------------------
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.


#export MANPAGER='nvim +Man!' # Enables highlighting on man pages, TODO: bolje je kad nvim nije man pager jer se cursor pojavljuje i tako neke stvari, bilo bi bolje mozda kad bi se vratilo na native ali kada bi jos i moglo da bude rice-ovano aka highlightovano, a mozda i da ostavim kao sa nvim-a, ali da samo koristim pravi naci za kretanje
#=================================================

#alias d="sudo dnf"
#alias D="sudo dnf -y"

alias sudo="sudo "
alias o="xdg-open"
alias v="$EDITOR"
alias em="emacsclient -nc"
alias e="$EDITOR"
alias mkdir="mkdir -pv"
alias mkd="mkdir -pv"
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"
alias rmdir="rmdir -v"
alias ls="ls -h --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias tree="tree -C" # Makes it colored
alias df="df -h"
alias du="du -h"
alias ka="killall -v"
alias killall="killall -v"

alias g="git add . ; git commit -m "c" ; git push"
alias ga="git add ."        # ga = Git Add
alias gc="git commit -m"    # gc = Git Commit
alias gp="git push"         # gp = Git Push
alias gs="git status"       # gs = Git Status

alias starwars="telnet towel.blinkenlights.nl"
alias bt="blueman-manager"
alias snd="pavucontrol"
alias term="exec alacritty&" # Opens terminal in current directory
alias c="ipython"

alias comp="/home/milos/reviv2/compile.sh"

# Just some small conviniences===========
alias cfv="$EDITOR ~/.config/nvim/init.vim"
alias cfz="$EDITOR ~/.config/zsh/.zshrc"
alias cfr="$EDITOR ~/fedora_setup/arch/README.md"
alias cfe="$EDITOR ~/.config/emacs/config.org"
alias cfs="$EDITOR ~/.config/sway/config"
alias cdc="cd ~/.config"
alias cds="cd ~/.scripts"

alias cda="cd ~/dev/arch_setup"
alias er="$EDITOR ~/fedora_setup/arch/README.md"
alias p="sudo pacman"
alias P="sudo pacman --noconfirm"

#===================

#alias bluelight="gammastep -l 44:21"
#alias brave-browser="~/brave-bin.sh -enable-features=UseOzonePlatform --ozone-platform=wayland"
#
# FZF ======================
# MUST be after zsh vim mode. Enables fzf <Ctrl+T>, <Ctrl+R>, <Alt+C>
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh



#export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =- binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} ||k"

#PS1 AREA============================

# Potencijalne boje (staviti u F{}) 196 160, Lex Fridman inspired
PS1="%F{196}%~$%f "

#PS1='-> '

#Mental outlaw, luke smith prompt
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#George hotz prompt
#PS1=" %n %{$fg[red]::%} %{$fg[green]%~%} %{$fg[blue]»%} %{$reset_color%}"

#-----
#LS_COLORS='di=1;35:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90:*.png=35:*.gif=36:*.jpg=35:*.c=92:*.jar=33:*.py=93:*.h=90:*.txt=94:*.doc=104:*.docx=104:*.odt=104:*.csv=102:*.xlsx=102:*.xlsm=102:*.rb=31:*.cpp=92:*.sh=92:*.html=96:*.zip=4;33:*.tar.gz=4;33:*.mp4=105:*.mp3=106'
#export LS_COLORS
#============================


# george hotz colors for macOS, does NOT work on linux, might consider converting it to linux
#export LS_COLORS=cxgxfxexbxegedabagacad
#-----


# Adds color to man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}
