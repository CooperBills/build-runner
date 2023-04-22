FROM debian:bookworm

# Install NodeJS and general dependencies
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    gnupg \
    libapr1-dev \
    libssl-dev \
    nodejs \
    npm \
    pkg-config \
    software-properties-common \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install -y \
    google-cloud-cli \
    google-cloud-cli-gke-gcloud-auth-plugin \
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
