#!/bin/sh

window_panes=
killlast=
mfact=

newpane() {
  tmux \
    split-window -t :.0\; \
    swap-pane -s :.0 -t :.1\; \
    select-layout main-vertical\; \
    resize-pane -t :.0 -x ${mfact}%
}

newpanecurdir() {
  tmux \
    split-window -t :.0 -c "#{pane_current_path}"\; \
    swap-pane -s :.0 -t :.1\; \
    select-layout main-vertical\; \
    resize-pane -t :.0 -x ${mfact}%
}

killpane() {
  if [ $window_panes -gt 1 ]; then
    tmux kill-pane -t :.\; \
         select-layout main-vertical\; \
         resize-pane -t :.0 -x ${mfact}%
  else
    if [ $killlast -ne 0 ]; then
      tmux kill-window
    fi
  fi
}

nextpane() {
  tmux select-pane -t :.+
}

prevpane() {
  tmux select-pane -t :.-
}

rotateccw() {
  tmux rotate-window -U\; select-pane -t 0
}

rotatecw() {
  tmux rotate-window -D\; select-pane -t 0
}

zoom() {
  tmux swap-pane -s :. -t :.0\; select-pane -t :.0
}

layouttile() {
  tmux select-layout main-vertical\; resize-pane -t :.0 -x ${mfact}%
}

float() {
  tmux resize-pane -Z
}

incmfact() {
  fact=$((mfact + 5))
  if [ $fact -le 95 ]; then
    tmux \
      setenv mfact $fact\; \
      resize-pane -t :.0 -x ${fact}%
  fi
}

decmfact() {
  fact=$((mfact - 5))
  if [ $fact -ge 5 ]; then
    tmux \
      setenv mfact $fact\; \
      resize-pane -t :.0 -x ${fact}%
  fi
}

window() {
  window=$1
  tmux selectw -t $window
}

# create a new window
newwindow() {
  tmux new-window -c "#{pane_current_path}"
}

# delete the current active window
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

# display a floating pane popup in the current pane path
popup() {
  tmux display-popup -E -d "#{pane_current_path}"
}

if [ $# -lt 1 ]; then
  echo "dwm.tmux.sh [command]"
  exit
fi

command=$1;shift
args=$*
set -- $(tmux display -p "#{window_panes} #{killlast} #{mfact}")
window_panes=$1
killlast=$2
mfact=$3

case $command in
  newpane) newpane;;
  newpanecurdir) newpanecurdir;;
  killpane) killpane;;
  nextpane) nextpane;;
  prevpane) prevpane;;
  rotateccw) rotateccw;;
  rotatecw) rotatecw;;
  zoom) zoom;;
  layouttile) layouttile;;
  float) float;;
  incmfact) incmfact;;
  decmfact) decmfact;;
  window) window $args;;
  newwindow) newwindow;;
  killwindow) killwindow;;
  popup) popup;;
  *) echo "unknown command"; exit 1;;
esac
