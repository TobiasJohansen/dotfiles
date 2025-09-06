function has_command {
  command -v "$1" >/dev/null 2>&1
}

# pnpm
if has_command pnpm; then
  export PNPM_HOME="/root/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end

# manual
if has_command nvim; then
  export MANPAGER="nvim +Man!"
fi

# starship
if has_command starship; then
  eval "$(starship init bash)"
fi

