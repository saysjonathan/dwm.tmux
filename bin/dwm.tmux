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

if [ $# -lt 1 ]; then
  echo "dwm.tmux.sh [command]"
  exit
fi

command=$1;shift
args=$*
set -- $(echo $(tmux display -p "#{window_panes}\n#{killlast}\n#{mfact}"))
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
  *) echo "unknown command"; exit 1;;
esac
