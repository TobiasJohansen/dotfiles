# Check if a .bashrc file exists and if so, source it
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
