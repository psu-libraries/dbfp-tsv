
FROM node:22-alpine3.20 AS dev
WORKDIR /app-dev
RUN apk add git
RUN git clone https://github.com/elmsln/hax11ty.git /app-dev
RUN rm -rf /hax11ty/src/content/*
COPY package.json .
COPY src .
RUN yarn install
CMD [ "yarn", "start" ]

FROM node:22-alpine3.20 AS build
WORKDIR /app
RUN apk add git
RUN git clone https://github.com/elmsln/hax11ty.git /app
RUN rm -rf /app/src/content/*
COPY . .
RUN yarn install
RUN yarn custom-build

FROM nginxinc/nginx-unprivileged AS prod
COPY --from=build /app/dist /usr/share/nginx/html
