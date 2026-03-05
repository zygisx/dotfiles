#!/usr/bin/env bash

ask_to_proceed() {
    read -p "${1:-}. Do you want to proceed? (y/N): " choice
    case "$choice" in
        y|Y )
            echo "Proceeding..."
            ;;
        * )
            echo "Aborting operation."
            exit 0 # Exit with 0 for a successful abort, or 1 for an error
            ;;
    esac
}

replace_files() {
    rm ~/$1
    ln -s $(pwd)/$1 ~/$1
}

safe_replace_files() {
    if diff -q ~/$1 $(pwd)/$1 >/dev/null; then
        replace_files "$1"
    else
        ask_to_proceed "Your $1 file differs from the one in this repository"
        replace_files "$1"
    fi
}

safe_replace_files ".pr_create.sh"
safe_replace_files ".tmux.conf"
safe_replace_files ".gitconfig"
safe_replace_files ".bashrc_productivity"
safe_replace_files ".bashrc_company"
safe_replace_files ".zshrc_productivity"
safe_replace_files ".zshrc_company"
safe_replace_files ".inputrc"
safe_replace_files ".config/atuin/config.toml"
