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
RUN wget https://github.com/starship/starship/releases/download/v0.55.0/starship-x86_64-unknown-linux-gnu.tar.gz
RUN tar -xvzf starship-x86_64-unknown-linux-gnu.tar.gz
RUN rm starship-x86_64-unknown-linux-gnu.tar.gz
RUN mv starship /usr/local/bin/starship

# Neovim
RUN apt-get install -y python3-neovim
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN tar -xvzf nvim-linux64.tar.gz
RUN rm nvim-linux64.tar.gz
RUN mv nvim-linux64/bin/nvim /usr/local/bin/nvim
RUN mv nvim-linux64/share/nvim /usr/local/share/nvim
RUN mv nvim-linux64/lib/nvim /usr/local/lib/nvim
RUN rm -rf nvim-linux64

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Node.js
RUN curl https://get.volta.sh | bash -s -- --skip-setup
RUN .volta/bin/volta install node@12
RUN .volta/bin/volta install yarn

COPY run.sh run.sh
EXPOSE 7681
ENTRYPOINT ["sh", "run.sh"]
