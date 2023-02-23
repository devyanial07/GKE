FROM node:10-alpine
RUN apk add --update nodejs npm
RUN nodejs --version
ARG COMMIT_REF
ARG BUILD_DATE

RUN mkdir -p /code
WORKDIR /code
ADD . /code
RUN npm install yarn
RUN yarn install --prod
#RUN npm install -g -s --no-progress yarn && yarn install --prod

ENV APP_COMMIT_REF=${COMMIT_REF} \
    APP_BUILD_DATE=${BUILD_DATE}

CMD [ "yarn", "install" ]
CMD [ "yarn", "start" ]
EXPOSE 3000