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

