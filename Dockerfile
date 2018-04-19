FROM docker

# This is needed to edit stuff.
RUN apk add --no-cache vim

# https://github.com/kubernetes/kops
RUN apk add --no-cache curl && \
    curl --location --output kops https://github.com/kubernetes/kops/releases/download/1.8.0/kops-linux-amd64 && \
    mv ./kops /bin && \
    chmod +x /bin/kops && \
    apk del curl

# Kubectl and kubefed.
# https://kubernetes.io/docs/tasks/federation/set-up-cluster-federation-kubefed/
RUN apk add --no-cache curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/kubernetes-client-linux-amd64.tar.gz && \
    tar -xzvf kubernetes-client-linux-amd64.tar.gz && \
    cp kubernetes/client/bin/kubefed /usr/local/bin && \
    chmod +x /usr/local/bin/kubefed && \
    cp kubernetes/client/bin/kubectl /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl && \
    apk del curl

# https://github.com/wercker/stern
RUN apk add --no-cache curl && \
    curl --location --output stern https://github.com/wercker/stern/releases/download/1.6.0/stern_linux_amd64 && \
    mv ./stern /bin && \
    chmod +x /bin/stern && \
    apk del curl

# https://github.com/kubernetes/helm
RUN apk add --no-cache curl && \
    cd /tmp && \
    curl --location --output helm.tar.gz https://kubernetes-helm.storage.googleapis.com/helm-v2.7.2-linux-amd64.tar.gz && \
    tar -xvzf helm.tar.gz && \
    mv ./linux-amd64/helm /bin && \
    chmod +x /bin/helm && \
    rm -rf /tmp/* && \
    apk del curl
