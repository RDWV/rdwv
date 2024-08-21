set -e
cd ../rdwv-docker/compose
echo "Building $1 image"
: "${ARCH:=amd64}"

create_manifest() {
    docker buildx imagetools create -t ${2}rdwv/$1:$CIRCLE_TAG ${2}rdwv/$1:$CIRCLE_TAG-amd64 ${2}rdwv/$1:$CIRCLE_TAG-arm
    docker buildx imagetools create -t ${2}rdwv/$1:stable ${2}rdwv/$1:stable-amd64 ${2}rdwv/$1:stable-arm
}

if [ -z ${MANIFEST+x} ]; then
    docker buildx build --progress plain --push --platform ${BUILD_PLATFORMS} --tag rdwv/$1:$CIRCLE_TAG-$ARCH --tag rdwv/$1:stable-$ARCH \
        --tag ghcr.io/rdwv/$1:$CIRCLE_TAG-$ARCH --tag ghcr.io/rdwv/$1:stable-$ARCH \
        -f $2 .
else
    create_manifest $1 ""
    create_manifest $1 "ghcr.io/"
fi
cd ../../.circleci
set +e
