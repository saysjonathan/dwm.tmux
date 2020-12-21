# Create new pane
bind -n M-n split-window -t :.0 \;\
        swap-pane -s :.0 -t :.1 \;\
        select-layout main-vertical \;\
        run "tmux resize-pane -t :.0 -x 50%"

# Create new pane in current directory
bind -n M-w split-window -b -t :.0 -c "#{pane_current_path}" \;\
        select-layout main-vertical \;\
        run "tmux resize-pane -t :.0 -x 50%"

# Kill pane
bind -n M-c kill-pane -t :. \;\
        select-layout main-vertical \;\
        run "tmux resize-pane -t :.0 -x 50%" \;\
        select-pane -t :.0

# Next pane
bind -n M-j select-pane -t :.+

# Prev pane
bind -n M-k select-pane -t :.-

# Rotate counterclockwise
bind -n M-, rotate-window -U \; select-pane -t 0

# Rotate clockwise
bind -n M-. rotate-window -D \; select-pane -t 0

# Focus selected pane
bind -n M-Space swap-pane -s :. -t :.0 \; select-pane -t :.0

# Refresh layout
bind -n M-r select-layout main-vertical \;\
        run "tmux resize-pane -t :.0 -x 50%"

# Zoom selected pane
unbind M-m
bind -n M-m resize-pane -Z
