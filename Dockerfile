# debian:bookworm as of 6/28/23
FROM debian@sha256:e7072ef5bbeaca98db3056a7d944d5dfb7a44d47770d10d54ee3f5a61144f049

# Install NodeJS, python, and general dependencies
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    docker.io \
    gnupg \
    libapr1-dev \
    libssl-dev \
    nodejs \
    npm \
    pipx=1.1.0-1 \
    pkg-config \
    python3=3.11.2-1+b1 \
    python3-pip=23.0.1+dfsg-1 \
    software-properties-common \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update -y && apt-get install -y \
        google-cloud-cli \
        google-cloud-cli-gke-gcloud-auth-plugin \
        kubectl \
    && rm -rf /var/lib/apt/lists/*

# Install google cloud sql proxy
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/bin/cloud_sql_proxy \
    && chmod ugo+x /usr/bin/cloud_sql_proxy

# Install terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt update && apt install -y \
    terraform \
    && rm -rf /var/lib/apt/lists/*

# Install bazelisk
RUN npm install -g @bazel/bazelisk

# run bazel --version to pre-load latest version of bazel
RUN bazel --version
