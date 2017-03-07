FROM galeksandrp/travistest:docker-css-user
USER root
RUN apt-get update && apt-get install -y git
WORKDIR /home/css/metamod
COPY .git .git
COPY product.version product.version
RUN chown -R css:css .
USER css
RUN git fetch --unshallow origin HEAD
RUN git remote add upstream https://github.com/alliedmodders/metamod-source.git
RUN git fetch upstream 1.10-dev
RUN wget $(echo "https://www.metamodsource.net/mmsdrop/$(cat product.version | grep -o '[0-9]*\.[0-9]*' | head -1)/mmsource-$(cat product.version | grep -o '[0-9.]*')-git$(git rev-list --count $(git merge-base upstream/1.10-dev HEAD))-linux.tar.gz") -O - | tar xz -C ~/css/cstrike
WORKDIR /home/css/css
