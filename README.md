# mac-setup

Configures macOS with my preferences and dev environment using Ansible

## Overview

This project automates the setup and configuration of macOS machines for development work. It uses Ansible to manage system preferences, install applications, and configure the development environment.

## Prerequisites

- macOS (Intel or Apple Silicon)
- Bash shell

The setup script will automatically install:
- Homebrew (if not already installed)
- Ansible (via Homebrew, if not already installed)

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/marinofelipe/mac-setup.git
cd mac-setup
```

2. Run the setup script:
```bash
./setup.sh
```

The script will guide you through the installation process with interactive prompts.

## Usage

### Basic Usage

Run all configuration tasks:
```bash
./setup.sh
```

### Advanced Options

```bash
./setup.sh [OPTIONS]
```

**Options:**
- `-h, --help` - Display help message
- `-t, --tags TAGS` - Run only tasks with specific tags (comma-separated)
- `-s, --skip TAGS` - Skip tasks with specific tags (comma-separated)
- `-c, --check` - Run in check mode (dry-run, no changes made)
- `-v, --verbose` - Run with verbose output

**Examples:**

Run only Homebrew and package installation:
```bash
./setup.sh -t homebrew,packages
```

Skip application installation:
```bash
./setup.sh -s applications
```

Dry-run to see what would change:
```bash
./setup.sh -c
```

Verbose mode for debugging:
```bash
./setup.sh -v
```

## Project Structure

```
.
├── ansible.cfg           # Ansible configuration
├── playbook.yml          # Main Ansible playbook
├── setup.sh              # Setup script with CLI interface
├── inventory/
│   └── hosts             # Ansible inventory file
├── roles/                # Custom Ansible roles (if any)
├── group_vars/           # Group-specific variables
└── host_vars/            # Host-specific variables
```

## What Gets Configured

The playbook configures the following:

### Homebrew Packages
- git
- wget
- curl
- vim
- python3
- node

### Applications (via Homebrew Cask)
- Visual Studio Code
- Google Chrome
- iTerm2
- Docker

### System Preferences
- Show all file extensions
- Always show scroll bars
- Disable window animations
- Auto-hide Dock
- Hide recent applications in Dock
- Set Dock tile size

## Customization

You can customize the setup by editing `playbook.yml`:

1. **Packages**: Modify the `homebrew_packages` list
2. **Applications**: Modify the `homebrew_cask_packages` list
3. **Preferences**: Add or modify tasks in the playbook

## Available Tags

- `homebrew` - Homebrew installation and setup
- `packages` - Package installation
- `cask` - Cask application installation
- `applications` - Application installation
- `preferences` - System preferences configuration
- `macos` - macOS-specific settings
- `dock` - Dock preferences

## Requirements

- macOS 11.0 or later
- Internet connection (for downloading packages)
- Administrator access (some tasks require sudo)

## License

This project is for personal use.

