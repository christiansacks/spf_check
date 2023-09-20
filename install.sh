#!/usr/bin/env bash

# Install script into path if not already installed
[[ -x /usr/local/bin/spf_check.sh ]] || sudo ln -sf $(pwd)/spf_check.sh /usr/local/bin/

# Install man page if not already installed
[[ -f /usr/share/man/man1/spf_check.sh.1 ]] || sudo cp $(pwd)/spf_check.sh.1 /usr/share/man/man1/
