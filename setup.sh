mkdir -p $HOME/.cache/dpp

mkdir -p $HOME/.cache/dpp/repos/github.com/Shougo
mkdir -p $HOME/.cache/dpp/repos/github.com/vim-denops

git clone https://github.com/Shougo/dpp.vim $HOME/.cache/dpp/repos/github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-ext-lazy $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy
git clone https://github.com/Shougo/dpp-ext-toml $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml
git clone https://github.com/Shougo/dpp-protocol-git $HOME/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git
git clone https://github.com/vim-denops/denops.vim $HOME/.cache/dpp/repos/github.com/vim-denops/denops.vim

ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
