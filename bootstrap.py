#!/usr/bin/env python
import os
from os.path import join, normpath, exists
from datetime import datetime
from time import mktime
from subprocess import check_call

home = os.path.expanduser('~')
dot_base = os.getcwd()

# (target, symlink)
symlinks = [
    ('gitignore_global', '.gitignore_global'),

    # vim
    ('vim', '.vim'),
    ('vimrc', '.vimrc'),

    # emacs
    ('.emacs', '.emacs'),
    ('emacs.d/init.el', '.emacs.d/init.el'),

    # Sublime Text 3
    ('sublime-text-3/Preferences.sublime-settings',
     '.config/sublime-text-3/Packages/User/Preferences.sublime-settings'),

    # zsh
    ('zsh/zshrc', '.zshrc'),
    ('zsh/jetprose.zsh-theme', '.oh-my-zsh/themes/jetprose.zsh-theme'),

    # virtualenv
    # FIXME: 'ln -s' by hand for now
    # ('virtualenv/postactivate', '.virtualenvs/postactivate'),

    # awesome wm
    ('awesome', '.config/awesome'),
    ('gtkrc-2.0', '.gtkrc-2.0'),
    ('gtkrc.mine', '.gtkrc.mine'),
    ('gtk-3.0', '.config/.gtk-3.0'),

    ('bin', 'bin'),
    ('profiles.clj', '.lein/profiles.clj'),
    ('inputrc', '.inputrc'),
    ('gitconfig', '.gitconfig'),
    ('terminator', '.config/terminator'),

    # mc
    ('mc/ini', '.config/mc/ini'),
    ('mc/mc.ext', '.config/mc/mc.ext'),
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
            suffix = '.backup-%d' % mktime(datetime.utcnow().utctimetuple())
            run(['mv', path, path + suffix])

        run(['ln', '-s', target, path])
    for f in after:
        f()

if __name__ == "__main__":
    bootstrap()
