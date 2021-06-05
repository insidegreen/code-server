FROM codercom/code-server:3.10.2

USER root
RUN apt-get update && apt-get upgrade -y
RUN apt-get install python3 \
  python3-pip \
  python3-dev \
  libffi-dev \
  jq \
  fzf \
  unzip -y

RUN pip3 install ansible azure-cli

RUN curl -L https://golang.org/dl/go1.16.4.linux-arm64.tar.gz -o go.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go.tar.gz


RUN curl -L https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip -o awscliv2.zip && unzip awscliv2.zip && ./aws/install
RUN rm -rf aws && rm awscliv2.zip

RUN curl -L https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm64.zip -o terraform.zip && unzip terraform.zip -d /usr/local/bin
RUN rm terraform.zip

RUN curl -L https://github.com/gruntwork-io/terragrunt/releases/download/v0.29.8/terragrunt_linux_arm64 -o /usr/local/bin/terragrunt && chmod +x /usr/local/bin/terragrunt

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl -o /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh

RUN curl -L https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_arm64.tar.gz | tar -xz -C /usr/local/bin
RUN curl -L https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_arm64.tar.gz | tar -xz -C /usr/local/bin
RUN curl -L https://github.com/derailed/k9s/releases/download/v0.24.10/k9s_v0.24.10_Linux_arm64.tar.gz | tar -xz -C /usr/local/bin

USER coder


RUN echo "\nexport PATH=/usr/local/go/bin:$PATH" >> ~/.bashrc

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
