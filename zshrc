# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/Mynah/.oh-my-zsh
export TERM=screen-256color

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
zsh_wifi_signal() {
    local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
    local airport=$(echo $output |grep 'AirPort' | awk -F': ' '{print $2}')
    if [ "airport" = "Off" ]; then
        local color='%F{yellow}'
        echo -n "%{$color%}Wifi Off"
    else
        local speed=$(echo $output |grep 'lastTxRate' | awk -F': ' '{print $2}')
        local unit="Mb/s"
        local color='%F{yellow}'

        [[ $speed -gt 100 ]] && color='%F{green}'
        [[ $speed -lt 50 ]] && color='%F{red}'
        echo -n "%{$color%}\uf1eb  $speed $unit%{%f%}"
    fi
}

todo_color() {
   local color="yellow"
   local num_todos=$(todo.sh |grep TODO | awk -F' ' '{print $2}')
   [[ $num_todos -gt 9 ]] && color="red"
   [[ $num_todos -lt 4 ]] && color="green"
   echo "$color"
}

custom_node_version() {
    local version=$(node -v |awk -F'v' '{print $2}')
    local node_icon="\ue718"
    echo -n "$version $node_icon%{%f%}"
}

new-alias() {
  local last_command=$(echo `history |tail -n2 |head -n1` | sed 's/[0-9]* //')
  echo alias $1="'""$last_command""'" >> ~/.zshrc
    . ~/.zshrc
}

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{black}%F{yellow} \uf415 `whoami` %f%k%F{black}%f "
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_left"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_NODE_VERSION="custom_node_version"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="yellow"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time todo custom_wifi_signal)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir vcs)
POWERLEVEL9K_ALWAYS_SHOW_USER=true
#DISABLE_UPDATE_PROMPT=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DELIMITER=".."
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_USER_ICON="\uF415"

# zsh tmux settings
ZSH_TMUX_AUTOSTART='true'

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Default username to hide "user@hostname" info
DEFAULT_USER="Mynah"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  npm
  tmux
  osx
  common-aliases
  colored-man-pages
  colorize
  extract
  heroku
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $(dirname $(gem which colorls))/tab_complete.sh

# User configuration


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
export EDITOR="/usr/local/bin/vim"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="~/.oh-my-zsh"
alias vimconfig="vim ~/.vimrc"
alias sourcezsh="source ~/.zshrc"
alias privoxyconfig="vim /usr/local/etc/privoxy/user.action"
alias lr="colorls --sf -l -a | lolcat"
alias lc="colorls"
alias t="/usr/local/bin/todo.sh"
alias tc="/usr/local/bin/todo.sh |lolcat"
alias gs="git status |lolcat"
alias g="git"
alias wannaknow="sudo python3 /Users/Mynah/GIT/E+A/WannaKnow/wannaknow.py"

# Now we only need to type the path of the
# directory to cd into it
setopt auto_cd

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.nvm/nvm.sh


export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/Mynah/Library/Python/3.6/bin:$PATH"


export PATH=/Users/Mynah/Library/Python/3.6/bin:/usr/local/sbin:/Users/Mynah/.nvm/versions/node/v9.0.0/bin:/Users/Mynah/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/Applications/Wireshark.app/Contents/MacOS:/Users/Mynah/.cargo/bin:~/GIT/MynahMarie/computer-science/Course_Notes/Curriculum/NandToTetris/nand2tetris/tools
