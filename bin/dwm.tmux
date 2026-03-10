#!/bin/sh

# Create a new pane in the current window
newpane() {
  tmux \
    split-window -t :.0\; \
    swap-pane -s :.0 -t :.1\; \
    $layout
}

# Create a new pane in the current directory in the current window
newpanecurdir() {
  tmux \
    split-window -t :.0 -c "#{pane_current_path}"\; \
    swap-pane -s :.0 -t :.1\; \
    $layout
}

# Kill the focused pane
killpane() {
  if [ $window_panes -gt 1 ]; then
    tmux kill-pane -t :.\; $layout
  else
    # Only kill the last pane if $killlast is set
    if [ $killlast -ne 0 ]; then
      tmux kill-window
    fi
  fi
}

# Move focus to the next pane sequentially
nextpane() {
  if [ "$monocle" -eq 0 ]; then
    tmux select-pane -t :.+
  else
    tmux select-pane -t :.+\; resize-pane -Z
  fi
}

# Move focus to the previous pane sequentially
prevpane() {
  if [ "$monocle" -eq 0 ]; then
    tmux select-pane -t :.-
  else
    tmux select-pane -t :.-\; resize-pane -Z
  fi
}

# Move the focused pane up the stack
stackup() {
  # Guard against moving panes 0 or 1
  if [ "$pane_index" -gt 1 ]; then
    tmux swap-pane -U\; $layout
  fi
}

# Move the focused pane down the stack
stackdown() {
  # Guard against moving the last pane or pane 0
  if [ "$pane_index" -lt $((window_panes - 1)) ] && [ "$pane_index" -ge 1 ]; then
    tmux swap-pane -D\; $layout
  fi
}

# Move current pane to a specific window
movepane() {
  window=$1
  newwin=0
  
  # Check if target window exists, create it if it doesn't
  if ! tmux has-session -t:$window 2>/dev/null; then
    newwin=1
    tmux new-window -d -t:$window
  fi
  
  # Move the current pane to the specified window and
  # retile the current window
  tmux \
    move-pane -t:$window\; \
    $layout

  # Select the window where we moved the pane
  if [ $newwin -ne 0 ]; then
    tmux \
      select-window -t:$window\; \
      kill-pane -t:.0
  else
    tmux select-window -t:$window
  fi

  # Apply the dwm layout to the target window
  tmux $layout
}

# Rotate the panes in the current window counterclockwise
rotateccw() {
  tmux rotate-window -U\; select-pane -t 0\; $layout
}

# Rotate the panes in the current window clockwise
rotatecw() {
  tmux rotate-window -D\; select-pane -t 0\; $layout
}

# Promote focused pane to main
zoom() {
  tmux swap-pane -s :. -t :.0\; select-pane -t :.0\; $layout
}

# Set the layout to tiled
tile() {
  tmux \
    setenv monocle 0\; \
    select-layout main-vertical\; \
    resize-pane -t :.0 -x ${mfact}%
}

# Toggle monocle mode, fullscreen focused pane
monocle() {
  if [ "$monocle" -eq 0 ]; then
    tmux \
      setenv monocle 1\; \
      resize-pane -Z
  else
    tmux \
      setenv monocle 0\; \
      resize-pane -Z
  fi
}

# Reapply the current layout
layout() {
  tmux $layout
}

# Increment the size of the main pane
incmfact() {
  fact=$((mfact + 5))
  if [ $fact -le 95 ]; then
    tmux \
      setenv mfact $fact\; \
      resize-pane -t :.0 -x ${fact}%
  fi
}

# Decrement the size of the main pane
decmfact() {
  fact=$((mfact - 5))
  if [ $fact -ge 5 ]; then
    tmux \
      setenv mfact $fact\; \
      resize-pane -t :.0 -x ${fact}%
  fi
}

# Select target window by index
window() {
  window=$1
  tmux selectw -t $window
}

# Create a new window
newwindow() {
  tmux new-window -c "#{pane_current_path}" -n ""
}

# Delete the current window
killwindow() {
  current_index=$(tmux display-message -p '#I')
  window_count=$(tmux display-message -p '#{session_windows}')
  tmux kill-window
  
  # If this wasn't the last window, we need to reorder
  if [ "$window_count" -gt 1 ]; then
    # Start at the first window that needs to be moved (the one after the deleted window)
    # and continue through all remaining windows
    i=$((current_index + 1))
    while [ $i -lt $window_count ]; do
      tmux move-window -s:$i -t:$((i-1))
      i=$((i + 1))
    done
  fi
}

# Display a floating pane popup in the current directory
popup() {
  tmux display-popup -E -d "#{pane_current_path}"
}


# Exit if no command is provided
if [ $# -lt 1 ]; then
  echo "dwm.tmux.sh [command]"
  exit
fi

command=$1;shift

# Cache args for passing into functions later
args=$@

# Set positional arguments from tmux env var checks
set -- $(tmux display -p "#{window_panes} #{pane_index} #{killlast} #{mfact} #{monocle}")
window_panes=$1
pane_index=$2
killlast=${3:-0}
mfact=${4:-50}
monocle=${5:-0}

# Specify the correct layout depending on the mode
if [ "$monocle" -eq 1 ]; then
  layout="select-layout main-vertical; resize-pane -t :.0 -x ${mfact}%; resize-pane -Z"
else
  layout="select-layout main-vertical; resize-pane -t :.0 -x ${mfact}%"
fi

case $command in
  newpane) newpane;;
  newpanecurdir) newpanecurdir;;
  killpane) killpane;;
  nextpane) nextpane;;
  prevpane) prevpane;;
  rotateccw) rotateccw;;
  rotatecw) rotatecw;;
  zoom) zoom;;
  tile) tile;;
  float) monocle;; # retain for backwards compatibility
  monocle) monocle;;
  layout) layout;;
  incmfact) incmfact;;
  decmfact) decmfact;;
  window) window $args;;
  newwindow) newwindow;;
  killwindow) killwindow;;
  popup) popup;;
  movepane) movepane $args;;
  stackup) stackup;;
  stackdown) stackdown;;
  *) echo "unknown command"; exit 1;;
esac
