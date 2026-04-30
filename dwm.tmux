#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
tmux set-option -g @dwm-tmux-bin "${CURRENT_DIR}/bin/dwm.tmux"
tmux source-file "${CURRENT_DIR}/lib/dwm.tmux"
