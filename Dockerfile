FROM docker

# This is needed to edit stuff.
RUN apk add --no-cache vim

# https://github.com/kubernetes/kops
RUN apk add --no-cache curl && \
    curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/local/bin/kops

# https://kubernetes.io/docs/tasks/tools/install-kubectl/
RUN apk add --no-cache curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    cp ./kubectl /usr/local/bin && \
    apk del curl

# https://github.com/wercker/stern
RUN apk add --no-cache curl && \
    curl -LO https://github.com/wercker/stern/releases/download/1.8.0/stern_linux_amd64 && \
    mv ./stern_linux_amd64 /bin/stern && \
    chmod +x /bin/stern && \
    apk del curl

# https://github.com/kubernetes/helm
RUN apk add --no-cache curl && \
    cd /tmp && \
    curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz && \
    tar -xvzf helm-v2.9.1-linux-amd64.tar.gz && \
    mv ./linux-amd64/helm /bin && \
    chmod +x /bin/helm && \
    rm -rf /tmp/* && \
    apk del curl
