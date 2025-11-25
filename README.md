# mac-setup

This project automates my personal macOS development environment setup using Ansible. Feel free to use it as inspiration for your own setup.

**Note:** This is configured for my specific needs. It could be improved by parameterizing settings to make it more reusable for others.

## What It Installs & Configures

- **Command Line Tools** - Xcode command line tools
- **Homebrew packages** - git, wget, curl, vim, python3, node, npm, git-delta, lazygit, onefetch, aria2, gh, mint, graphviz, and more
- **Xcode** - iOS/macOS development toolchain
- **Mint packages** - Swift tools (xcparse, spmgraph)
- **Ruby** - Ruby environment for development
- **Zed** - Code editor configuration
- **Git** - Global git configuration and SSH signing setup
- **SSH** - SSH keys and known hosts
- **macOS defaults** - System preferences (Dock, Finder, keyboard, trackpad, screenshots)

## Prerequisites

- macOS (Intel or Apple Silicon)
- The setup script will automatically install Homebrew and Ansible if needed

## Usage

Run the full setup:
```bash
./setup.sh
```

Dry-run to see what would change:
```bash
./setup.sh -c
```

Run with verbose output:
```bash
./setup.sh -v
```

Install specific Xcode version (defaults to the latest):
```bash
./setup.sh --xcode-version 16.0
./setup.sh --xcode-version --latest
```

## Run Specific Roles

Use tags to run only specific parts:

```bash
# Install only Homebrew packages
./setup.sh -t brew

# Configure only git
./setup.sh -t git_config

# Setup SSH and known hosts
./setup.sh -t ssh,known_hosts

# Skip Xcode and Mint dependencies
./setup.sh -s xcode

# Skip configuring macOS system defaults
./setup.sh -s macos_defaults

# Skip installing the Zed editor
./setup.sh -s zed
```

## Available Tags

- `command_line_tools` - Xcode command line tools
- `brew` - Homebrew packages
- `ruby` - Ruby environment
- `xcode` - Xcode installation
- `mint` - Mint Swift packages
- `zed` - Zed editor configuration
- `git_config` - Git configuration
- `ssh` - SSH setup
- `known_hosts` - SSH known hosts
- `macos_defaults` - macOS system preferences
- `tooling` - All tooling setup (command_line_tools, git_config, ssh, known_hosts)
- `dependencies` - All dependencies (brew, ruby, mint)
- `applications` - All applications (zed, xcode)
- `macos` - macOS settings (macos_defaults)

# Acknowledgments
- It uses most of @unnamedd's cool [git config setup](https://gist.github.com/unnamedd/2794781)
- The idea to create my own macOS setup dates back to when @pietrocaselani first showed me [his own](https://github.com/pietrocaselani/setup-my-mac)
