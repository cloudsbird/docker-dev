FROM docker/dev-environments-default:latest

RUN apt update && apt -y upgrade

# Install Essential Tools
RUN apt -y install build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev curl libpq-dev git

# Install Rbenv
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

# Install latest Ruby
RUN ~/.rbenv/bin/rbenv install 3.1.2
RUN ~/.rbenv/bin/rbenv global 3.1.2

# Install NVM and Install Node 16
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN source /root/.bashrc && nvm install 16
SHELL ["/bin/bash", "--login", "-c"]
