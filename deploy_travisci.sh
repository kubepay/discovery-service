#!/bin/sh

# Builds and deploys JAR build artifact to GitHub (acts as binary repository)
# Builds immutable Docker Image, deploying the JAR, above.

# Uses encrypted environment variables in .travis.yml file used here
# travis encrypt GH_TOKEN=<your_token_hash> --add
# travis encrypt COMMIT_AUTHOR_EMAIL=<your_email_here> --add
# travis encrypt GH_ARTIFACT_REPO=github.com/<your_repo_path>.git --add
# travis encrypt DOCKER_USERNAME=<your_username> --add
# travis encrypt DOCKER_PASSWORD=<your_password> --add

#set -x

# Builds and deploys JAR build artifact to GitHub (acts as binary repository)
# cd build/libs
# git init
# git config user.name "travis-ci"
# git config user.email "abhiesa@gmail.com"

# git add *.jar
# git commit -m "Deploy Travis CI Build #${TRAVIS_BUILD_NUMBER} artifacts to GitHub"
# git push --force --quiet "https://${GH_TOKEN}@${GH_ARTIFACT_REPO}" master:build-artifacts > /dev/null 2>&1

# Builds immutable Docker Image, deploying the JAR, above.
cd -
docker login -u="abhiesa" -p="${DOCKER_PASSWORD}"

set -ex

sleep 120 # wait for automated Docker Hub build to finish...

IMAGE="abhiesa/discovery-service"
IMAGE_TAG="2.0.${TRAVIS_BUILD_NUMBER}"

docker build --file=Dockerfile --tag=${IMAGE}:${IMAGE_TAG} --rm=true .
docker push ${IMAGE}:${IMAGE_TAG}
docker tag ${IMAGE}:${IMAGE_TAG} ${IMAGE}:latest
docker push ${IMAGE}:latest
