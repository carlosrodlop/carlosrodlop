#!/usr/bin/env bash

HERE="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd -P "${HERE}/.." && pwd)"

# shellcheck source=/dev/null
source "$HERE/.env"
# shellcheck source=/dev/null
source "$HERE/.profile"

case "$1" in
    clean)
        docker container prune --force
        docker volume prune --force
        docker system prune -a --force
    ;;
    build)
        rm build.log || WARN 'There is not an existing Build log file'
        #docker build -t "$AGENT" --no-cache --progress=plain images/asdf-agent 2>&1 | tee build.log
        docker build -t "$AGENT" --progress=plain images/asdf-agent 2>&1 | tee build.log
    ;;
    container-fix) 
        echo "Enter the Name for the fixed container"
        read -r container
        docker run --name "$container" -it \
        --mount type=bind,source="$ROOT",target=/root/labs \
        --mount type=bind,source="$HOME/.aws",target=/root/.aws \
        --mount type=bind,source="$HOME/.ssh",target=/root/.ssh \
        -v "$ROOT"/agent/v_kube:/root/.kube/ \
        -v "$ROOT"/agent/v_tmp:/tmp/ \
        -p 8080:8080 \
        "$AGENT"
    ;;
    container)
        echo "Enter the Name for the removal container"
        read -r container
        docker run --name "$container" --rm -it \
        --mount type=bind,source="$ROOT",target=/root/labs \
        --mount type=bind,source="$HOME/.aws",target=/root/.aws \
        --mount type=bind,source="$HOME/.ssh",target=/root/.ssh \
        -v "$ROOT"/agent/v_kube:/root/.kube/ \
        -v "$ROOT"/agent/v_tmp:/tmp/ \
        "$AGENT"
    ;;
    ssh)
        docker exec -it "$AGENT" bash
    ;;
    scan)
        docker login --username "$DOCKER_USER" --password "$DOCKER_PASS"
        docker scan "$AGENT" > synk-scan.txt
    ;;
    *)
        ERROR "That option is not supported"
    ;;
esac