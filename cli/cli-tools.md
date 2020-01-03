CLI stuff
=========

## CLI Tools

* fzf
* ack
* autojump
* diff-so-fancy

## Useful CLI stuff

### Launch and detach from a terminal

Launch a process, possibly with `&` to put it immediately in the background, then use `disown`:

    disown studio.sh

### Cool aliases

Search for all C++ files in a codebase. Tweak to your liking.

    alias findcpp="find . -name \"*.h\" -o -name \"*.inl\" -o -name \"*.cpp\" -o -name \"*.hpp\""

### Remember to use xargs to process a list of results from a command

E.g. a simple search and replace in a C++ codebase: 

    findcpp | xargs sed -i "s/old/new/g"

### Use fzf to quickly open a file in vim

    vim $(fzf)
