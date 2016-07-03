#!/usr/bin/env sh
nvim="$HOME/.nvim"
repos="https://github.com/jimzhan/nvim"
config=$HOME/.config

info() {
    printf "\e[34m[⊙]\e[0m ${1}\n"
}

error() {
    printf "\e[31m[✘]\e[0m ${1}\n"
}

success() {
    printf "\e[32m[✔]\e[0m ${1}\n"
}


# ------------------------------
# ensure there is a global config folder.
# ------------------------------
if [ ! -d $config/nvim ]; then
    mkdir -p $config/nvim
fi


# ------------------------------
# backup/unlink existing nvim if any.
# ------------------------------
if [ -L $config/nvim/init.vim]; then
    unlink $config/nvim/init.vim
    info "existing NeoVim#init.vim unlinked"
elif [ -f $config/nvim/init.vim]; then
    mv $config/nvim/init.vim $config/nvim/init.vim.bak
    info "init.vim => init.vim.bak"
fi


# clone/update from remote repos
# ------------------------------
if [ ! -d $nvim ]; then
    info "Setting up NeoVim..."
    git clone $repos $nvim
    ln -s $nvim/init.vim $HOME/.config/nvim/init.vim
    mkdir $nvim/tmp
    success "NeoVim is ready to launch now"
else
    cd $nvim && git pull -v
    success "NeoVim is now updated"
fi
