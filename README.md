dwm.tmux
===
[dwm](http://dwm.suckless.org/)-inspired tiling pane management for Tmux.

![](https://raw.githubusercontent.com/saysjonathan/dwm.tmux/master/screenshot.png)

## Dependencies
dwm.tmux requires tmux > 3.2.

## Installation
To install, use the provided `Makefile`:

```sh
git clone https://github.com/saysjonathan/dwm.tmux.git
cd dwm.tmux
make
```

By default `dwm.tmux` uses `/usr/local` as it's prefix. To change the prefix:

```sh
make PREFIX=$HOME
```

Ensure that `$PREFIX/bin` is in your `PATH`.

## Setup
To use, source the `dwm.tmux` tmux config:

```sh
echo 'source-file /usr/local/lib/dwm.tmux' >> $HOME/.tmux.conf
```

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
- `decmfact` `Meta-h` Decrease the main pane space factor
- `incmfact` `Meta-l` Increase the main pane space factor

Also defined are environment variables to tweak behavior:

- `mfact` Main pane space factor, the size of the main pane as a percentage of total window size
- `killlast` If value is greater than `0`, kill pane even if its the last pane in a window

### Customizations
Keybindings and default values can be set in a configuration file:

```
setenv -g killlast 1 # kill pane even if it's the last
bind -n M-q killpane
bind -n M-t newpanecurdir
```

Customizations should be added after the `source-file` command which loads `dwm.tmux`.

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
