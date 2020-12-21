dwm.tmux
===
[dwm](http://dwm.suckless.org/)-inspired tiling pane management for Tmux.

![](https://raw.githubusercontent.com/saysjonathan/dwm.tmux/master/screenshot.png)

## Setup
To use dwm.tmux:

- `git clone git@github.com/saysjonathan/dwm.tmux.git $HOME/.dwm.tmux`
- `echo 'source-file $HOME/.dwm.tmux/dwm.tmux' >> $HOME/.tmux.conf`

dwm.tmux requires tmux > 3.1.

## Usage
`dwm.tmux` defines the following complex commands as environment variables, each with a default keybinding

- `TMUXDWM_NEWPANE` `Meta-N` Create a new pane and place it in the Main pane
- `TMUXDWM_NEWPANECDIR` `Meta-W` Create a new pane starting in the same directory and place it in the Main pane
- `TMUXDWM_KILLPANE` `Meta-C` Close the current pane. If the pane is in the Main pane, close the pane and promote the first pane in the stack to the Main pane
- `TMUXDWM_NEXTPANE` `Meta-J` Select the next pane (clockwise)
- `TMUXDWM_PREVPANE` `Meta-K` Select the previous pane (counterclockwise)
- `TMUXDWM_ROTATECCW` `Meta-,` Rotate panes counterclockwise
- `TMUXDWM_ROTATECW` `Meta-.` Rotate panes clockwise
- `TMUXDWM_REFRESH` `Meta-R` Refresh layout (return to Main and Stack setup)
- `TMUXDWM_FOCUSPANE` `Meta-space` Place select pane in the Main pane
- `TMUXDWM_ZOOM` `Meta-m` Zoom selected pane

### Custom keybindings
Custom keybindings can be created by creating a new binding for the appropriate command:

```
bind -n M-q $TMUXDWM_KILLPANE
bind -n M-t $TMUXDWM_NEWPANECDIR
```

Custom keybindings should be added after the `source-file` command which loads dwm.tmux.

## Details

Similar to dwm, windows are always organised as follows:

```
 ====================================
|                 |        S1        | 
|                 |==================
|      M(0)       |        S2        | 
|                 |==================
|                 |        S3        | 
 ====================================
```

A large Main pane is placed on the left side of the screen while a stack of smaller panes is placed on the right. The Main pane is always pane 0,  while the stack of panes is numbered sequentially in ascending order.



