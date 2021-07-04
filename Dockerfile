FROM ubuntu:20.10

ARG PASSWORD

WORKDIR /root

RUN printf "${PASSWORD}\n${PASSWORD}\n" | passwd

RUN apt-get update

# Basic packages
RUN apt-get install -y build-essential
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y tree
RUN apt-get install -y ripgrep

# Git
RUN apt-get install -y git
RUN ln -s .config/git/.gitconfig .gitconfig

# tmux
RUN apt-get install -y tmux
RUN ln -s .config/tmux/.tmux.conf .tmux.conf

# ttyd
RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64
RUN chmod +x /usr/local/bin/ttyd

# Zsh
RUN apt-get install -y zsh
RUN chsh -s /usr/bin/zsh
RUN ln -s .config/zsh/.zshrc .zshrc

# Neovim
RUN apt-get install -y neovim
RUN apt-get install -y python3-neovim

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN .cargo/bin/cargo install cargo-edit

# Node.js
RUN curl https://get.volta.sh | bash -s -- --skip-setup
RUN .volta/bin/volta install node@12
RUN .volta/bin/volta install yarn

COPY run.sh run.sh
EXPOSE 7681
ENTRYPOINT ["sh", "run.sh"]
