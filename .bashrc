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

# manual
if has_command nvim; then
  export MANPAGER="nvim +Man!"
fi

# starship
if has_command starship; then
  eval "$(starship init bash)"
fi
