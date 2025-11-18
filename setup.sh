#!/bin/bash

# macOS Setup Script
# This script configures a macOS machine using Ansible

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install Homebrew
install_homebrew() {
    if ! command_exists brew; then
        print_warning "Homebrew is not installed."
        read -p "Do you want to install Homebrew? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH for Apple Silicon Macs
            if [[ $(uname -m) == 'arm64' ]]; then
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
        else
            print_error "Homebrew is required. Exiting."
            exit 1
        fi
    else
        print_info "Homebrew is already installed."
    fi
}

# Function to install Ansible
install_ansible() {
    if ! command_exists ansible; then
        print_warning "Ansible is not installed."
        read -p "Do you want to install Ansible? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installing Ansible via Homebrew..."
            brew install ansible
        else
            print_error "Ansible is required. Exiting."
            exit 1
        fi
    else
        print_info "Ansible is already installed (version: $(ansible --version | head -n1))."
    fi
}

# Function to display help
show_help() {
    cat << EOF
macOS Setup Script

Usage: ./setup.sh [OPTIONS]

OPTIONS:
    -h, --help          Display this help message
    -t, --tags TAGS     Run only tasks with specific tags (comma-separated)
    -s, --skip TAGS     Skip tasks with specific tags (comma-separated)
    -c, --check         Run in check mode (dry-run)
    -v, --verbose       Run with verbose output

EXAMPLES:
    ./setup.sh                          Run all tasks
    ./setup.sh -t homebrew,packages     Run only Homebrew and package tasks
    ./setup.sh -s applications          Skip application installation
    ./setup.sh -c                       Dry-run mode
    ./setup.sh -v                       Verbose mode

EOF
}

# Parse command line arguments
TAGS=""
SKIP_TAGS=""
CHECK_MODE=""
VERBOSE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -t|--tags)
            TAGS="--tags $2"
            shift 2
            ;;
        -s|--skip)
            SKIP_TAGS="--skip-tags $2"
            shift 2
            ;;
        -c|--check)
            CHECK_MODE="--check"
            shift
            ;;
        -v|--verbose)
            VERBOSE="-vvv"
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Main execution
main() {
    print_info "Starting macOS setup..."
    
    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi
    
    # Install prerequisites
    install_homebrew
    install_ansible
    
    # Confirm before running
    print_info "Ready to configure your macOS machine."
    if [[ -n "$CHECK_MODE" ]]; then
        print_info "Running in CHECK MODE (dry-run)."
    fi
    if [[ -n "$TAGS" ]]; then
        print_info "Running with tags: $TAGS"
    fi
    if [[ -n "$SKIP_TAGS" ]]; then
        print_info "Skipping tags: $SKIP_TAGS"
    fi
    
    read -p "Do you want to continue? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Setup cancelled."
        exit 0
    fi
    
    # Run Ansible playbook
    print_info "Running Ansible playbook..."
    if ansible-playbook playbook.yml $TAGS $SKIP_TAGS $CHECK_MODE $VERBOSE; then
        print_info "macOS setup completed successfully!"
    else
        print_error "Setup failed. Please check the errors above."
        exit 1
    fi
}

# Run main function
main
