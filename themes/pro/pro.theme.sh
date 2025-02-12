#! bash oh-my-bash.module

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${green}✓"
SCM_THEME_PROMPT_PREFIX=" ${blue}scm:( "
SCM_THEME_PROMPT_SUFFIX="${blue} )"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${green}✓"
GIT_THEME_PROMPT_PREFIX="${green}git:( "
GIT_THEME_PROMPT_SUFFIX="${green} )"

function git_prompt_info {
  git_prompt_vars
  echo -e "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
}

function _omb_theme_PROMPT_COMMAND() {
  PS1="\h: \W $(scm_prompt_info)${_omb_prompt_reset_color} $ "
}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
