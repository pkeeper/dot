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

    # zsh
    ('zsh/zshrc', '.zshrc'),
    ('zsh/jetprose.zsh-theme', '.oh-my-zsh/themes/jetprose.zsh-theme'),

    # virtualenv
    ('.virtualenvs/postactivate', 'virtualenv/postactivate'),

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


def run(command):
    print ' '.join(command)
    check_call(command)


def install_zsh():
    oh_zsh_url = 'git://github.com/robbyrussell/oh-my-zsh.git'
    run(['git', 'clone', oh_zsh_url, join(home, '.oh-my-zsh')])


def bootstrap_vim():
    run(['git', 'submodule', 'init'])
    run(['git', 'submodule', 'update'])
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
            run(['mv', path, path + suffix])

        run(['ln', '-s', target, path])
    for f in after:
        f()

if __name__ == "__main__":
    bootstrap()
