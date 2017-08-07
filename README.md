dwm.tmux
===
[dwm](http://dwm.suckless.org/)-inspired tiling pane management for Tmux.

![](https://raw.githubusercontent.com/saysjonathan/dwm.tmux/master/screenshot.png)

## Usage
dwm.tmux defines several keybindings to assist with pane management:

- `Meta-N` Create a new pane and place it in the Main pane
- `Meta-W` Create a new pane starting in the same directory and place it in the Main pane
- `Meta-C` Close the current pane. If the pane is in the Main pane, close the pane and promote the first pane in the stack to the Main pane
- `Meta-J` Select the next pane (clockwise)
- `Meta-K` Select the previous pane (counterclockwise)
- `Meta-,` Rotate panes counterclockwise
- `Meta-.` Rotate panes clockwise
- `Meta-R` Refresh layout

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

A large Master pane is placed on the left side of the screen while a stack of smaller panes is placed on the right. The Master pane is always pane 0,  while the stack of panes is numbered sequentially in ascending order.

## Setup
To use dwm.tmux:

- `git clone git@github.com/saysjonathan/dwm.tmux.git $HOME/.dwm.tmux`
- `echo 'source-file $HOME/.dwm.tmux/dwm.tmux' >> $HOME/.tmux.conf`

dwm.tmux requires tmux > 2.0.
