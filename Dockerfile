FROM google/cloud-sdk

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update && apt-get install -y \
    curl \
    nodejs \
    gnupg \
    software-properties-common \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/bin/cloud_sql_proxy \
    && chmod ugo+x /usr/bin/cloud_sql_proxy

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install -y \
    terraform \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @bazel/bazelisk

# run bazel --version to pre-load latest version of bazel
RUN bazel --version
