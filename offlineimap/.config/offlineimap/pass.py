#!/usr/bin/env python3
import os

def get_pass(key):
    text = os.popen(
        "gpg -q --for-your-eyes-only --no-tty -d ~/.config/.mailauthinfo.gpg"
    ).read().strip().split("\n")
    text = [i.split() for i in text]
    password = {i[0]: i[1] for i in text}
    return password[key]
