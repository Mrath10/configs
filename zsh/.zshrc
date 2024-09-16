# Lines configured by zsh-newuser-install
# Enable colors and change prompt:
autoload -U colors && colors

PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

HISTFILE=~/.cache/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

#alias#
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias icat='kitten icat'
alias icat='img2sixel'
alias uqvpn="sudo echo \"Sudo first\" && openconnect https://vpn.uq.edu.au --useragent=AnyConnect --cookieonly | sudo openconnect https://vpn.uq.edu.au --useragent=AnyConnect --cookie-on-stdin"
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mayv/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# script by mattmc3 from https://github.com/mattmc3/zsh_unplugged
function plugin-load {
  local repo plugdir initfile initfiles=()
  : ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules \
        https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
      (( $#initfiles )) || { echo >&2 "No init file '$repo'." && continue }
      ln -sf $initfiles[1] $initfile
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}
 #list of github repos for plusings
 repos=( 

	#plugins we load in the end
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-history-substring-search
	zsh-users/zsh-autosuggestions
      )

#start ssh agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

#load the plugins
plugin-load $repos

export TERM=xterm-256color
export PATH=~/matlab/bin:$PATH
export BROWSER=firefox
