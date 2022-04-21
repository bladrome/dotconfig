#!/usr/bin/env python3
import os

def get_pass():
    return os.popen(
        "gpg -q --no-tty -d ~/.config/.mailauthinfo.gpg"
    ).read().strip()
