setenv -g tmuxdwm_version 0.1.0

# Main pane count
setenv -g nmain 1

# Toggle killing last pane
setenv -g killlast 0

# Increase main pane count
set -g command-alias[100] incnmain='setenv -g -F nmain "#{e|+:#{nmain},1}"'

# Decrease main pane count
set -g command-alias[101] decnmain='setenv -g -F nmain "#{e|-:#{nmain},1}"'

# Create new pane
set -g command-alias[102] newpane='
  split-window -t :.0;
  swap-pane -s :.0 -t :.1;
  select-layout main-vertical;
  resize-pane -t :.0 -x 50%;
'

# Create new pane in current directory
set -g command-alias[103] newpanecurdir='
  split-window -b -t :.0 -c "#{pane_current_path}";
  select-layout main-vertical;
  resize-pane -t :.0 -x 50%;
'

# Kill pane
set -g command-alias[104] killpane='
  if "[ #{window_panes} -gt 1 ]" {
    kill-pane -t :.;
    select-layout main-vertical;
    resize-pane -t :.0 -x 50%;
  } {
    if "[ #{killlast} -gt 0 ]" {
      kill-window
    } {
      select-pane -t :.0;
    }
  }
'

# Next pane
set -g command-alias[105] nextpane='select-pane -t :.+'

# Prev pane
set -g command-alias[106] prevpane='select-pane -t :.-'

# Rotate counterclockwise
set -g command-alias[107] rotateccw='
  rotate-window -U;
  select-pane -t 0;
'

# Rotate clockwise
set -g command-alias[108] rotatecw='
  rotate-window -D;
  select-pane -t 0;
'

# Zoom
set -g command-alias[109] zoom='
  swap-pane -s :. -t :.0;
  select-pane -t :.0;
'

# Tile layout
set -g command-alias[110] layout_tile='
  select-layout main-vertical;
  resize-pane -t :.0 -x 50%;
'

# Float pane
set -g command-alias[111] float='resize-pane -Z'

bind -n M-i incnmain
bind -n M-d decnmain
bind -n M-n newpane
bind -n M-w newpanecurdir
bind -n M-c killpane
bind -n M-j nextpane
bind -n M-k prevpane
bind -n M-< rotateccw
bind -n M-> rotatecw
bind -n M-Enter zoom
bind -n M-t layout_tile
bind -n M-Space float
