#!/usr/bin/env bash

rm ~/.tmux.conf
ln -s $(pwd)/.tmux.conf ~/.tmux.conf

rm ~/.gitconfig
ln -s $(pwd)/.gitconfig ~/.gitconfig
