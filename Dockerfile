FROM ubuntu:20.04

ARG PASSWORD

WORKDIR /root

RUN printf "${PASSWORD}\n${PASSWORD}\n" | passwd

RUN apt-get update

# Basic packages
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get install -y curl

# ttyd
RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64
RUN chmod +x /usr/local/bin/ttyd

# Zsh
RUN apt-get install -y zsh
RUN chsh -s /usr/bin/zsh
RUN mkdir -p .config/antigen
RUN curl -L git.io/antigen > .config/antigen/antigen.zsh
COPY .zshrc .zshrc

# Neovim
RUN apt-get install -y neovim
RUN apt-get install -y python3-neovim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN mkdir -p .config/nvim
COPY init.vim .config/nvim/init.vim

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Node.js
RUN curl https://get.volta.sh | bash -s -- --skip-setup
RUN .volta/bin/volta install node@12
RUN .volta/bin/volta install yarn

# Directories to be mounted
RUN mkdir repos

COPY run.sh run.sh
EXPOSE 7681
ENTRYPOINT ["sh", "run.sh"]
