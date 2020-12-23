setenv -g tmuxdwm_version 0.1.0
setenv -g killlast 0 # Toggle killing last pane
setenv -g mfact 50   # Main pane area factor

set -g command-alias[100] newpane='run-shell "dwm.tmux newpane"'
set -g command-alias[101] newpanecurdir='run-shell "dwm.tmux newpanecurdir"'
set -g command-alias[102] killpane='run-shell "dwm.tmux killpane"'
set -g command-alias[103] nextpane='run-shell "dwm.tmux nextpane"'
set -g command-alias[104] prevpane='run-shell "dwm.tmux prevpane"'
set -g command-alias[105] rotateccw='run-shell "dwm.tmux rotateccw"'
set -g command-alias[106] rotatecw='run-shell "dwm.tmux rotatecw"'
set -g command-alias[107] zoom='run-shell "dwm.tmux zoom"'
set -g command-alias[108] layouttile='run-shell "dwm.tmux layouttile"'
set -g command-alias[109] float='run-shell "dwm.tmux float"'
set -g command-alias[110] incmfact='run-shell "dwm.tmux incmfact"'
set -g command-alias[111] decmfact='run-shell "dwm.tmux decmfact"'

set-hook -g pane-exited 'run-shell "dwm.tmux layouttile"'

bind -n M-n newpane
bind -n M-w newpanecurdir
bind -n M-c killpane
bind -n M-j nextpane
bind -n M-k prevpane
bind -n M-< rotateccw
bind -n M-> rotatecw
bind -n M-Enter zoom
bind -n M-t layouttile
bind -n M-Space float
bind -n M-h decmfact
bind -n M-l incmfact
