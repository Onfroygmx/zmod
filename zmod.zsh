#!/usr/bin/env zsh
#!/bin/zsh
## Modules manager for zsh

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

autoload -Uz \
  @source_compile                \
  @module_list

# FUNCTION: zmod. [[[
# Main function directly exposed to user
zmod() {
  case "$1" in
    load)
      shift
      @source_compile "$@"
      return 0
      ;;
    list)
      shift
      @mlist_modules "$@"
      return 0
      ;;
    *)
      println "No Function found"
      return 0
      ;;
   esac
} # ]]]
