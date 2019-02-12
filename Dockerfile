FROM docker

# This is needed to edit stuff.
RUN apk add --no-cache vim

# https://github.com/kubernetes/kops
RUN apk add --no-cache curl && \
    curl -LO https://github.com/kubernetes/kops/releases/download/1.10.1/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/local/bin/kops

# https://kubernetes.io/docs/tasks/tools/install-kubectl/
RUN apk add --no-cache curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.10.12/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    cp ./kubectl /usr/local/bin && \
    apk del curl

# https://github.com/wercker/stern
RUN apk add --no-cache curl && \
    curl -LO https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64 && \
    mv ./stern_linux_amd64 /bin/stern && \
    chmod +x /bin/stern && \
    apk del curl
