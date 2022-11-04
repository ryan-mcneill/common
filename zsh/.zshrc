# Open VS Code on a mac from command line
# Usage: `code` or `code file.ext`
code() { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Check what process is running on a particular port
# Usage: `port:check 3000`
port:check() { lsof -i tcp:$1; }

# Kill a process running on a particular port
# Usage: `port:kill 3000`
port:kill() { kill $(lsof -ti:$1) }

# Automatically pick up the node version for each new terminal from the closest .nvrmc file
# Usage: automatic
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc