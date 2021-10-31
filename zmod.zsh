#!/usr/bin/env zsh
#!/bin/zsh
## Modules manager for zsh
zmodload zsh/datetime

# Zsh Plugin Standard compatibility
# 0 – the plugin manager provides the ZERO parameter,
# f - … supports the functions subdirectory,
# b - … supports the bin subdirectory,
# u - … the unload function,
# U - … the @zsh-plugin-run-on-unload call,
# p – … the @zsh-plugin-run-on-update call,
# i – … the zsh_loaded_plugins activity indicator,
# P – … the ZPFX global parameter,
# s – … the PMSPEC global parameter itself (i.e.: should be always present).
export PMSPEC="0fis"
export _ZMOD_DIR="${${(%):-%x}:h}"

export ZCACHEDIR="${TMPDIR:-/tmp}/zsh-${UID:-user}"
[[ ! -d "$ZCACHEDIR" ]] && mkdir -p "${ZCACHEDIR}"

fpath=( "${_ZMOD_DIR}/functions" $fpath[@] )

typeset -aU fpath

typeset -ag _ZMOD_modules

ZSH_SCRIPT=${0##*/}

autoload -Uz \
  @list                 \
  @load                 \
  @update               \
  @zcompile

_zmod_help() {
  print -r -- "usage: ${ZSH_SCRIPT:r} [COMMANDS] [...]"
  print -r --
  print -r -- 'COMMANDS'
  print -r -- '  -h,--help,help  display help information'
  print -r -- '  compile <path>  zcompile specified file(s)'
  print -r -- '  list <options>  list loaded modules'
  print -r -- '  load <path>     load module'
  print -r -- '  update <path>   update git plugins in specified folder'
}

# FUNCTION: zmod. [[[
# Main function directly exposed to user
zmod() {

  local cmd
  [[ -n $1 ]] && cmd=$1 && shift

  case $cmd in
    load|list|update)
      @${cmd} "$@"
      ;;
    compile)
      @zcompile "$@"
      ;;
    -h|--help|help)
      _zmod_help
      ;;
    *)
      printf "No Function found\n"
      return 0
      ;;
   esac
} # ]]]
