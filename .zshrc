# Created by newuser for 5.9
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zsh plugin

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light olets/zsh-abbr

zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

zinit cdreplay -q

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# Shell inegrations

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config "$HOME/Document/dotfiles/Terminal/shell/ohmyposh/omp.toml")"
#  
# Path change

path+=('home/wateir/.cargo/bin') 
export PATH
export EDITOR=micro


# Keybinds

bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

## Aliases, abbreviation  and function

alias eza='eza --group-directories-first --icons=always'
alias send='curl -F "file=@-" 0x0.st'

#pu to remove package
alias pu="pacman -Qq|fzf -m --preview \"pacman -Qil {}\" --layout=reverse|xargs -ro sudo pacman -Rns $(pacman -Qtdq)"

mkcd(){ mkdir -p $1 && cd $1 } 

# pi install from AUR (using paru, work same with yay or other AUR Helper)
pi () {paru -Sl | awk '{print $2($4=="" ? "" : " \*")}' | fzf -q "$1" -m --preview 'cat <(echo {1} | cut -d " " -f 1 | paru -Si -) <(echo {1} | cut -d " " -f 1 | paru -Fl - | awk "{print $2}")' | cut -d " " -f 1 | xargs -ro paru -S}

shell(){
	export SWITCH_SHELL="$1"
	fastfetch --config shelllogin.jsonc
	echo ""
	$1
	export SWITCH_SHELL="zsh"
	fastfetch --config shelllogin.jsonc
	unset SWITCH_SHELL
}

# Completion

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --group-directories-first'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt histignorespace
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Yazy

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# Start of Zsh

if [ $(tput lines) -gt 30 ] && [ $(tput cols) -gt 61 ]; then
	fastfetch --config minimal.jsonc
	echo ""
else
	LittleFetch
	echo ""
fi
