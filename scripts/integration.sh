#!/usr/bin/env bash
set -euo pipefail

export ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
$ROOT/scripts/install_tools.sh

GINKGO_NODES=${GINKGO_NODES:-3}
GINKGO_ATTEMPTS=${GINKGO_ATTEMPTS:-1}

for stack in windows2012R2 windows2016; do
  export CF_STACK=${stack}
  cd $ROOT/src/binary/integration
  ginkgo -r --flakeAttempts=$GINKGO_ATTEMPTS -nodes $GINKGO_NODES --slowSpecThreshold=60
done

