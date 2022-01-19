#! bash oh-my-bash.module

# based off of n0qorg
# looks like, if you're in a git repo:
# ± ~/path/to (branch ✓) $
# in glorious red / blue / yellow color scheme

_omb_theme_PROMPT_COMMAND() {
  # Save history
  history -a
  history -c
  history -r
  # displays user@server in purple
  # PS1="$red$(scm_char) $purple\u@\h$_omb_prompt_reset_color:$blue\w$yellow$(scm_prompt_info)$(_omb_prompt_print_ruby_env) $_omb_prompt_black\$$_omb_prompt_reset_color "
  # no user@server
  PS1="$red$(scm_char) $blue\w$yellow$(scm_prompt_info)$(_omb_prompt_print_ruby_env) $_omb_prompt_black\$$_omb_prompt_reset_color "
  PS2='> '
  PS4='+ '
}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND

SCM_NONE_CHAR='·'
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${green}✓"
SCM_THEME_PROMPT_PREFIX=" ("
SCM_THEME_PROMPT_SUFFIX="${yellow})"
RVM_THEME_PROMPT_PREFIX=" ("
RVM_THEME_PROMPT_SUFFIX=")"
