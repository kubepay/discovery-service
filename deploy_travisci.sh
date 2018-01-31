# Builds immutable Docker Image, deploying the JAR, above.
cd -
docker login -u="abhiesa" -p="${DOCKER_PASSWORD}"

set -ex

sleep 15 # wait for automated Docker Hub build to finish...

IMAGE="abhiesa/discovery-service"
IMAGE_TAG="2.0.${TRAVIS_BUILD_NUMBER}"
mvn clean install -DskipTests=true
docker build --file=Dockerfile --tag=${IMAGE}:${IMAGE_TAG} --rm=true .
docker push ${IMAGE}:${IMAGE_TAG}
docker tag ${IMAGE}:${IMAGE_TAG} ${IMAGE}:latest
docker push ${IMAGE}:latest
