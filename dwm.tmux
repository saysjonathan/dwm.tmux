TMUXDWM_VERSION=0.1.0

# Create new pane
TMUXDWM_NEWPANE={
  split-window -t :.0
  swap-pane -s :.0 -t :.1
  select-layout main-vertical
  resize-pane -t :.0 -x 50%
}
bind -n M-n $TMUXDWM_NEWPANE

# Create new pane in current directory
TMUXDWM_NEWPANECDIR={
  split-window -b -t :.0 -c "#{pane_current_path}"
  select-layout main-vertical
  resize-pane -t :.0 -x 50%
}
bind -n M-w $TMUXDWM_NEWPANECDIR

# Kill pane (only kill if we have more than one pane)
TMUXDWM_LASTPANE="tmux display-message -p '#{window_panes}' | awk '{exit(!($0>1))}'"
TMUXDWM_KILLPANE={
  if-shell "$TMUXDWM_LASTPANE" {
    kill-pane -t :.
    select-layout main-vertical
    resize-pane -t :.0 -x 50%
  }
  select-pane -t :.0
}

bind -n M-c $TMUXDWM_KILLPANE

## Next pane
TMUXDWM_NEXTPANE={ select-pane -t :.+ }
bind -n M-j $TMUXDWM_NEXTPANE

## Prev pane
TMUXDWM_PREVPANE={ select-pane -t :.- }
bind -n M-k $TMUXDWM_PREVPANE

# Rotate counterclockwise
TMUXDWM_ROTATECCW={
  rotate-window -U
  select-pane -t 0
}
bind -n M-, $TMUXDWM_ROTATECCW 

# Rotate clockwise
TMUXDWM_ROTATECW={
  rotate-window -D
  select-pane -t 0
}
bind -n M-. $TMUXDWM_ROTATECW

# Focus selected pane
TMUXDWM_FOCUSPANE={
  swap-pane -s :. -t :.0
  select-pane -t :.0
}
bind -n M-Space $TMUXDWM_FOCUSPANE

# Refresh layout
TMUXDWM_REFRESH={
  select-layout main-vertical
  resize-pane -t :.0 -x 50%
}
bind -n M-r $TMUXDWM_REFRESH

# Zoom selected pane
TMUXDWM_ZOOM={ resize-pane -Z }
bind -n M-m $TMUXDWM_ZOOM
