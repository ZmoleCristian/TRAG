autoload -Uz vcs_info
function git_indicator() {
    local unpushed="$(git rev-list --count @{upstream}..HEAD 2>/dev/null)"
    local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
    local unstaged=$(git diff --numstat 2>/dev/null | wc -l)
    local indicator=""
    if [[ "$unpushed" -gt 0 ]]; then
        indicator+="  ${unpushed}"
    fi
    if [[ "$untracked" -gt 0 || "$unstaged" -gt 0 ]]; then
        indicator+="  "
    fi
    if [[ "$unstaged" -gt 0 ]]; then
        indicator+="  "
    fi
    echo "$indicator"
}

temp="28.1 "
# Calculate prompt exectime
function preexec() {
    timer=${timer:-$SECONDS}
}

precmd() {
    if [ $timer ]; then
        timer_show=$(($SECONDS - $timer))
        prompt_exectime="%K{yellow}%F{black} 󱫡 ${timer_show}s %F{yellow}%K{black}"
        unset timer
    fi
    vcs_info
    psvar[1]="$(git_indicator)"
}
#if var timer is empty set it to zero
if [ -z "$timer" ]; then
    timer=0
fi
# Configure vcs_info format
zstyle ':vcs_info:git:*' formats ' %b%c%u%m'
zstyle ':vcs_info:git:*' actionformats ' %b|%a%c%u%m'
zstyle ':vcs_info:git:*' stagedstr '  '
zstyle ':vcs_info:git:*' unstagedstr '  '
zstyle ':vcs_info:git:*' check-for-changes true


# Define prompt vars
setopt PROMPT_SUBST
prompt_top="%F{white}%K{blue} 󱞬 %f%k"
prompt_bottom="%F{white}%K{blue} 󱞪 %f%k"
prompt_host="%F{white}%K{blue}  % archlinux "
prompt_user="%F{white}%K{blue}  Zakky %f%k"
prompt_dir='$(echo "%K{blue} "  ${(%):- %~} | sed "s#/#  #g") '
transition_bluewhite="%F{blue}%K{white}%f%k"
transition_whiteblue="%F{white}%K{blue}%f%k"
transition_whitecyan="%F{white}%K{cyan}%f%k"
transition_cyanblack="%F{cyan}%K{black}%f%k"
transition_yellowblue="%F{yellow}%K{blue}%f%k"
transition_cyanred="%F{cyan}%K{red}%f%k"
transition_whiteblack="%F{white}%K{black}%f%k"
prompt_returncode="%K{red}%F{black} %? %F{yellow}"
prompt_temp="%K{blue} ${temp} %F{blue}%K{black}"
prompt_char="%F{white} %f"

# Spawn the prompt
PROMPT=${prompt_top}${prompt_host}${transition_bluewhite}${transition_whiteblue}${prompt_dir}${transition_bluewhite}${transition_whitecyan}'%K{cyan}%F{black}${vcs_info_msg_0_}${psvar[1]}${transition_cyanred}${prompt_returncode}${prompt_exectime}${transition_yellowblue}${prompt_temp}
'${prompt_bottom}${prompt_user}${transition_bluewhite}${transition_whiteblack}${prompt_char}

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# These common commands are just too long! Abbreviate them.
alias \
	ka="killall" \
	g="git" \
	trem="transmission-remote" \
	YT="youtube-viewer" \
	sdn="shutdown -h now" \
	e="$EDITOR" \
	v="$EDITOR" \
	p="pacman" \
	xi="sudo xbps-install" \
	xr="sudo xbps-remove -R" \
	xq="xbps-query" \
	z="zathura"

alias \
	lf="lfub" \
	magit="nvim -c MagitOnly" \
	ref="shortcuts >/dev/null; source ${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc ; source ${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc ; source ${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"
