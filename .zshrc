source ~/.config/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme minimal

antigen apply

export PATH=~/.cargo/bin:$PATH
export PATH=~/.volta/bin:$PATH