#!/usr/bin/env python
import os
from os.path import join, normpath, exists
from datetime import datetime
from subprocess import check_call

home = os.path.expanduser('~')
dot_base = os.getcwd()

# (target, symlink)
symlinks = [
    # vim
    ('vim', '.vim'),
    ('vimrc', '.vimrc'),

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


def install_zsh():
    pass


def bootstrap_vim():
    command = ['git', 'submodule', 'init']
    print ' '.join(command)
    check_call(command)
    command = ['git', 'submodule', 'update']
    print ' '.join(command)
    check_call(command)
    # TODO: install Command-T


# run this before making symlinks
before = [install_zsh]
# run this after making symlinks
after = [bootstrap_vim]


def bootstrap():
    for f in before:
        f()
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
    for f in after:
        f()

if __name__ == "__main__":
    bootstrap()
