# Overview

My dotfile repository.  This way, multiple configuration files can be organized
in separate directories and be version controlled.

# Usage

## Setup

1. `git clone git@github.com:ianrabt/dotfiles.git ~/dotfiles`

## Installing Packages

Configuration files are organized by program or use.  Each of these groupings
will be referred as a package.  To install the files associated with a specific
program,

1. `cd ~/dotfiles`
2. `stow zsh`

`stow` is an excellent tool for generating symlinks in a situation like this.
Files can be copied or symlinked manually if `stow` is not installed.  Each
package has the same hierarchy as `$HOME`.  So for instance, to version control
the file `~/.config/program/prg.cfg` into the package `package`, move the file
to `~/dotfiles/package/.config/program/prg.cfg`.

# Directory Hierarchy

TODO
