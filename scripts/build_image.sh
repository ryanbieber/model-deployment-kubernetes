# Input env variables from pipeline
echo "REGISTRY_URL=${REGISTRY_URL}"
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}"
echo "IMAGE_NAME_PULL=${IMAGE_NAME_PULL}"
echo "IMAGE_NAME_MODEL=${IMAGE_NAME_MODEL}"
echo "IMAGE_NAME_PUSH=${IMAGE_NAME_PUSH}"
echo "GIT_BRANCH=${GIT_BRANCH}"
echo "GIT_COMMIT=${GIT_COMMIT}"
echo "DOCKER_ROOT=${DOCKER_ROOT}"
echo "DOCKER_FILE_PULL=${DOCKER_FILE_PULL}"
echo "DOCKER_FILE_PUSH=${DOCKER_FILE_PUSH}"
echo "DOCKER_FILE_MODEL=${DOCKER_FILE_MODEL}"


echo "Linting Dockerfile"
npm install -g dockerlint
dockerlint -f ${DOCKER_ROOT}/${DOCKER_FILE_PULL}
dockerlint -f ${DOCKER_ROOT}/${DOCKER_FILE_MODEL}
dockerlint -f ${DOCKER_ROOT}/${DOCKER_FILE_PUSH}

echo "Linting Done"


echo -e "Existing images in registry"
ibmcloud cr images

echo "Building Images"

set -x
docker build -f ${DOCKER_ROOT}/${DOCKER_FILE_PULL} -t ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME_PULL}:latest .
docker build -f ${DOCKER_ROOT}/${DOCKER_FILE_MODEL} -t ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME_MODEL}:latest .
docker build -f ${DOCKER_ROOT}/${DOCKER_FILE_PUSH} -t ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME_PUSH}:latest .

set +x

