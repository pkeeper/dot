#!/usr/bin/env python
import os
from os.path import join, normpath, exists
from datetime import datetime
from subprocess import check_call

home = os.path.expanduser('~')
dot_base = os.getcwd()

# (target, symlink)
symlinks = [
    # awesome wm
    ('awesome', '.config/awesome'),
    ('gtkrc-2.0', '.gtkrc-2.0'),
    ('gtkrc.mine', '.gtkrc.mine'),

    ('inputrc', '.inputrc'),
    ('gitconfig', '.gitconfig'),
    ('terminator', '.config/terminator'),
]
symlinks = [
    (normpath(join(dot_base, tp)), normpath(join(home, sp)))
    for tp, sp in symlinks
]


def bootstrap():
    for target, path in symlinks:
        # check that symlink path does not exists
        if exists(path):
            print path, 'exists, backing up'
            suffix = '.backup-%s' % datetime.now().strftime('%Y%m%d')
            command = ['mv', path, path + suffix]
            print ' '.join(command)
            check_call(command)

        command = ['ln', '-s', target, path]
        print ' '.join(command)
        check_call(command)
    # TODO: bootstrap vim (plugins as submodules, install Commant-T)

if __name__ == "__main__":
    bootstrap()
