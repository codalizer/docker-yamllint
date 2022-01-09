FROM node:lts-alpine

WORKDIR /usr/app

RUN npm install yamllint

ENTRYPOINT ["yamllint"]