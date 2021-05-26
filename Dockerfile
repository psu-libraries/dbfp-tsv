
# FROM node:14.17.0-alpine3.13 as dev
# WORKDIR /app
# COPY package.json .
# RUN yarn install
# COPY . .
# CMD [ "yarn", "start" ]

FROM node:14.17.0-alpine3.13 as build
WORKDIR /app
RUN apk add git
RUN git clone https://github.com/elmsln/hax11ty.git /app
RUN rm -rf /app/src/content/*
COPY . .
RUN yarn install
RUN yarn custom-build

FROM nginx as prod
COPY --from=build /app/dist /usr/share/nginx/html
