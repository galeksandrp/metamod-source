FROM galeksandrp/travistest:docker-css
RUN apt-get update
RUN apt-get install -y git
COPY .git /root/metamod/.git
WORKDIR /root/metamod
COPY product.version product.version
RUN git fetch --unshallow origin HEAD
RUN git remote add upstream https://github.com/alliedmodders/metamod-source.git
RUN git fetch upstream master
RUN wget $(echo "https://www.metamodsource.net/mmsdrop/$(cat product.version | grep -o '[0-9]*\.[0-9]*' | head -1)/mmsource-$(cat product.version | grep -o '[0-9.]*')-git$(git rev-list --count $(git merge-base upstream/master HEAD))-linux.tar.gz") -O - | tar xz -C ~/css/cstrike
WORKDIR /root/css
