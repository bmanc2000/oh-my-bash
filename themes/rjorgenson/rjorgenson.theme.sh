#! bash oh-my-bash.module
# port of zork theme

# set colors for use throughout the prompt
# i like things consistent
OMB_THEME_BRACKET_COLOR="${OMB_THEME_BRACKET_COLOR:-${blue}}"
OMB_THEME_STRING_COLOR="${OMB_THEME_STRING_COLOR:-${green}}"

SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${OMB_THEME_STRING_COLOR}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

PROMPT_CHAR="${OMB_THEME_BRACKET_COLOR}➞ ${normal}"
if [[ $OSTYPE =~ "darwin" ]]; then
    PROMPT_CHAR="${OMB_THEME_BRACKET_COLOR}➞  ${normal}"
fi

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

TITLEBAR=""
case $TERM in
    xterm*) TITLEBAR="\[\033]0;\w\007\]" ;;
esac


__my_rvm_ruby_version() {
    local gemset ; gemset=$(echo "${GEM_HOME}" | awk -F'@' '{print $2}')
    local version ; version=$(echo "${MY_RUBY_HOME}" | awk -F'-' '{print $2}')
    [ "${gemset}" != "" ] && gemset="@${gemset}"
    local full="${version}${gemset}"
    [ "${full}" != "" ] \
      && echo "${OMB_THEME_BRACKET_COLOR}[${OMB_THEME_STRING_COLOR}${full}${OMB_THEME_BRACKET_COLOR}]${normal}"
}

is_vim_shell() {
    if [ -n "${VIMRUNTIME}" ] ; then
        echo "${OMB_THEME_BRACKET_COLOR}[${OMB_THEME_STRING_COLOR}vim shell${OMB_THEME_BRACKET_COLOR}]${normal}"
    fi
}

function is_integer() { # helper function to make sure input is an integer
    [ "$1" -eq "$1" ] > /dev/null 2>&1
    return $?
}

# XXX do we need/want to integrate with todo.sh? We don't provide it and I
# can't find a version online that accepts ls as an input
todo_txt_count() {
    if _omb_util_command_exists todo.sh; then # is todo.sh installed
        local count=$(todo.sh ls \
          | awk '/TODO: [0-9]+ of ([0-9]+) tasks shown/ { print $4 }')
        if is_integer "${count}" ; then # did we get a sane answer back
            echo "${OMB_THEME_BRACKET_COLOR}[${OMB_THEME_STRING_COLOR}T:$count${OMB_THEME_BRACKET_COLOR}]$normal"
        fi
    fi
}

modern_scm_prompt() {
    local CHAR=$(scm_char)
    if [ ! "${CHAR}" = "${SCM_NONE_CHAR}" ] ; then
        printf "%s" \
          "${OMB_THEME_BRACKET_COLOR}[${CHAR}${OMB_THEME_BRACKET_COLOR}]" \
          "[${OMB_THEME_STRING_COLOR}$(scm_prompt_info)${OMB_THEME_BRACKET_COLOR}]$normal"
        printf "\n"
    fi
}

_omb_theme_PROMPT_COMMAND() {
    local my_host="${OMB_THEME_STRING_COLOR}\h${normal}";
    local my_user="${OMB_THEME_STRING_COLOR}\u${normal}";
    local my_path="${OMB_THEME_STRING_COLOR}\w${normal}";
    local bracket_c="${OMB_THEME_BRACKET_COLOR}"

    local line2 ; line2="${bracket_c}└─$(todo_txt_count)${PROMPT_CHAR}"
    # nice prompt
    case "$(id -u)" in
        0)
          my_user="${bold_red}\u${normal}";
          line2="${bracket_c}└─${PROMPT_CHAR}"
        ;;
    esac

    PS1="${TITLEBAR}"
    PS1="${PS1}${bracket_c}┌─[${my_user}${bracket_c}][$my_host${bracket_c}]"
    PS1="${PS1}$(modern_scm_prompt)"
    PS1="${PS1}$(__my_rvm_ruby_version)"
    PS1="${PS1}${bracket_c}[${my_path}${bracket_c}]$(is_vim_shell)"
    PS1="${PS1}\n${line2}"
}

PS2="└─${PROMPT_CHAR}"
PS3=">> "

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
