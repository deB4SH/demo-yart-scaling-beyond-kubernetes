#!/usr/bin/env bash
source build.sh
#test
if [ -d ./test/result ]; then
    rm -rf ./test/result
fi
mkdir ./test/result
${cli_cmd} run --rm \
    -v ./test/result:/output:z \
    -v ./config:/data:z \
    --userns=keep-id:uid=1000,gid=1000 \
    $(echo "$REGISTRY/demo-creator-case-two:$TAG")
#check for diffs
echo ""
echo "=========="
echo "DIFF BETWEEN RESULT AND EXPECTED"
echo "=========="
echo ""
diff --brief --recursive --no-dereference --new-file  expected test/result