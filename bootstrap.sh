git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

mkdir -p ~/.oh-my-zsh/plugins/copydir && \
    touch ~/.oh-my-zsh/plugins/copydir/copydir.plugin.zsh && \
    echo $(curl https://raw.githubusercontent.com/mwilc0x/ohmyzsh/master/plugins/copydir/copydir.plugin.zsh) >> ~/.oh-my-zsh/plugins/copydir/copydir.plugin.zsh

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
