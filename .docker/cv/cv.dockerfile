FROM pandoc/latex:2.9

RUN apk add make texlive

ENV TEXMF /usr/share/texmf-dist \
    IMAGE_ROOT_PATH=.docker/cv

COPY ${IMAGE_ROOT_PATH}/actions/entrypoint.sh /entrypoint.sh
