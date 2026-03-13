function has_command {
  command -v "$1" >/dev/null 2>&1
}

# pnpm
export PNPM_HOME="/root/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# nvim
if has_command nvim; then
  export EDITOR="nvim"
  export MANPAGER="nvim +Man!"
  export VISUAL="nvim"
fi

# starship
if has_command starship; then
  eval "$(starship init bash)"
fi

# keychain
if has_command keychain; then
  eval $(keychain --eval --quiet)
fi

# turn of notification bell sound
bind 'set bell-style none'

# source local config if it exists
if [ -f "${HOME}/.bashrc.local.sh" ]; then
  . "${HOME}/.bashrc.local.sh"
fi
