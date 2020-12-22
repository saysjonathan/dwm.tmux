dwm.tmux
===
[dwm](http://dwm.suckless.org/)-inspired tiling pane management for Tmux.

![](https://raw.githubusercontent.com/saysjonathan/dwm.tmux/master/screenshot.png)

## Setup
To use dwm.tmux:

- `git clone git@github.com/saysjonathan/dwm.tmux.git $HOME/.dwm.tmux`
- `echo 'source-file $HOME/.dwm.tmux/dwm.tmux' >> $HOME/.tmux.conf`

dwm.tmux requires tmux > 3.2.

## Usage
`dwm.tmux` defines the following command aliases, each with a default keybinding:

- `newpane` `Meta-n` Create a new pane and place it in the Main pane
- `newpanecurdir` `Meta-w` Create a new pane starting in the same directory and place it in the Main pane
- `killpane` `Meta-c` Close the current pane. If the pane is in the Main pane, close the pane and promote the first pane in the stack to the Main pane
- `nextpane` `Meta-j` Select the next pane (clockwise)
- `prevpane` `Meta-k` Select the previous pane (counterclockwise)
- `rotateccw` `Meta-,` Rotate panes counterclockwise
- `rotatecw` `Meta-.` Rotate panes clockwise
- `layouttile` `Meta-t` Refresh layout (return to Main and Stack setup)
- `zoom` `Meta-Enter` Place select pane in the Main pane
- `float` `Meta-Space` Switch pane to floating fullscreen

### Custom keybindings
Custom keybindings can be created by creating a new binding for the appropriate command:

```
bind -n M-q killpane
bind -n M-t newpanecurdir
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



