#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Homebrew if it is not already installed
if ! command_exists brew; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to user's PATH
    echo "adding path"
    user_home=$(eval echo "~$(whoami)")
    brew_shelenv_command='eval $(/opt/homebrew/bin/brew shellenv)'
    echo "$brew_shelenv_command" >> "$user_home/.zprofile"
    eval "$brew_shelenv_command"
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install required packages
echo "Installing curl, git, and ansible..."
brew install curl git ansible

# Install Xcode command line tools
if ! xcode-select -p > /dev/null; then
    echo "Installing Xcode command line tools..."
    xcode-select --install
else
    echo "Xcode command line tools are already installed."
fi

echo "All tasks completed successfully."
chmod -x "$0"
