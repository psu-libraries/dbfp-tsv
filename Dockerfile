
FROM node:14.17.6-alpine3.13 as dev
WORKDIR /app-dev
RUN apk add git
RUN git clone https://github.com/elmsln/hax11ty.git /app-dev
RUN git checkout ac09a311d469aa55ffe6a3a0f68aab9d0de9e7a3
RUN rm -rf /hax11ty/src/content/*
COPY package.json .
COPY src .
RUN yarn install
CMD [ "yarn", "start" ]

FROM node:14.17.6-alpine3.13 as build
WORKDIR /app
RUN apk add git
RUN git clone https://github.com/elmsln/hax11ty.git /app
RUN git checkout ac09a311d469aa55ffe6a3a0f68aab9d0de9e7a3
RUN rm -rf /app/src/content/*
COPY . .
RUN yarn install
RUN yarn custom-build

FROM nginxinc/nginx-unprivileged as prod
COPY --from=build /app/dist /usr/share/nginx/html
