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

RUN apk add --no-cache curl && \
    curl -L https://github.com/heptio/velero/releases/download/v1.0.0/velero-v1.0.0-linux-amd64.tar.gz -o velero.tar.gz && \
    mkdir velero && tar --extract --gzip --directory velero --strip-components 1 --file ./velero.tar.gz && \
    mv velero/velero /usr/local/bin && \
    rm -rf velero && \
    apk del curl
