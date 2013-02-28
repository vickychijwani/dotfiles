# -*- mode: shell-script -*-
function setprompt() {
  if [[ $UID -eq 0 ]]; then
    local PROMPT_COLOR='red'
    local PROMPT_COLOR2='red'
    local PROMPT_COLOR3='red'
    local PROMPT_COLOR4='black'
    local PROMPT_COLOR5='red'
    local PROMPT_CHAR='»'
  else
    local PROMPT_COLOR='yellow'
    local PROMPT_COLOR2='green'
    local PROMPT_COLOR3='black'
    local PROMPT_COLOR4='red'
    local PROMPT_COLOR5='blue'
    local PROMPT_CHAR='→'
  fi

  local DEFAULT_RUBY=$([[ -f .rvmrc ]] && rvm list default | sed -e '/^$/ d' -e '/^Default Ruby.*$/ d' -e 's/^\s*//g' | cut -d' ' -f1)
  local PROMPT_HEADER_RVM_INFO=$([[ -f .rvmrc ]] && ~/.rvm/bin/rvm-prompt i v p g)
  PROMPT_HEADER_RVM_INFO=$(echo $PROMPT_HEADER_RVM_INFO | sed 's/^'$DEFAULT_RUBY'$//')

  local PROMPT_HEADER_LEFT="
%{$fg_bold[$PROMPT_COLOR]%}%n %{$reset_color%}at %{$fg_bold[$PROMPT_COLOR5]%}%m %{$reset_color%}in %{$fg_bold[$PROMPT_COLOR2]%}%~ %{$fg[$PROMPT_COLOR3]%}"
  local PROMPT_HEADER_RIGHT=" %{$reset_color%}%{$fg_bold[$PROMPT_COLOR4]%}$PROMPT_HEADER_RVM_INFO"
  local PROMPT_CONTENT="
%{$fg_bold[$PROMPT_COLOR]%}$PROMPT_CHAR %{$reset_color%}"
  RPROMPT='$(git_prompt_info)'

  local PROMPT_HEADER_LEFT_LEN
  PROMPT_HEADER_LEFT_LEN=${(S)PROMPT_HEADER_LEFT//\%\{*\%\}} # search-and-replace color escapes
  PROMPT_HEADER_LEFT_LEN=${(%)PROMPT_HEADER_LEFT_LEN} # expand all escapes
  PROMPT_HEADER_LEFT_LEN=${#PROMPT_HEADER_LEFT_LEN} # count the chars

  local PROMPT_HEADER_RIGHT_LEN
  PROMPT_HEADER_RIGHT_LEN=${(S)PROMPT_HEADER_RIGHT//\%\{*\%\}} # search-and-replace color escapes
  PROMPT_HEADER_RIGHT_LEN=${(%)PROMPT_HEADER_RIGHT_LEN} # expand all escapes
  PROMPT_HEADER_RIGHT_LEN=${#PROMPT_HEADER_RIGHT_LEN} # count the chars

  local SEP_LEN=$(($COLUMNS-$PROMPT_HEADER_LEFT_LEN-$PROMPT_HEADER_RIGHT_LEN))
  SEP=${(r:$SEP_LEN::—:)}
  PROMPT=$PROMPT_HEADER_LEFT$SEP$PROMPT_HEADER_RIGHT$PROMPT_CONTENT

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}⚡"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
}

function precmd {
  setprompt
  _z --add "$(pwd -P)"
}
