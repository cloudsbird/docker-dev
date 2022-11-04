FROM docker/dev-environments-default:latest

RUN apt update && apt -y upgrade

# Install Essential Tools
RUN apt -y install build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev curl libpq-dev \
                   git mercurial make binutils bison gcc

# Install Rbenv
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash && \ 
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc && \
    ~/.rbenv/bin/rbenv install 3.1.2 && ~/.rbenv/bin/rbenv global 3.1.2

# Install NVM and Install Node 16
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && \
    source /root/.bashrc && nvm install 16

# install GVM 
SHELL ["/bin/bash", "-c"]

RUN apt update && \
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) && \
    source /root/.gvm/scripts/gvm && \
    gvm install go1.19.3 -B && \
    gvm use go1.19.3 --default && \
    apt clean all && \    
    source /root/.gvm/scripts/gvm
