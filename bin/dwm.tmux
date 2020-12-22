#!/bin/sh

newpane() {
  tmux \
    split-window -t :.0\; \
    swap-pane -s :.0 -t :.1\; \
    select-layout main-vertical\; \
    resize-pane -t :.0 -x 50%
}

newpanecurdir() {
  tmux \
    split-window -b -t :.0 -c "#{pane_current_path}"\; \
    swap-pane -s :.0 -t :.1\; \
    select-layout main-vertical\; \
    resize-pane -t :.0 -x 50%
}

killpane() {
  panes=$(tmux display -p "#{window_panes}")
  killlast=$(tmux display -p "#{killlast}")

  if [ $panes -gt 1 ]; then
    tmux kill-pane -t :.\; \
         select-layout main-vertical\; \
         resize-pane -t :.0 -x 50%
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
  tmux select-layout main-vertical\; resize-pane -t :.0 -x 50%
}

float() {
  tmux resize-pane -Z
}

if [ $# -lt 1 ]; then
  echo "dwm.tmux.sh [command]"
  exit
fi

command=$1;shift
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
  *) echo "unknown command"; exit 1;;
esac
