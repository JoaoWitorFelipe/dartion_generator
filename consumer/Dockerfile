FROM dart:stable AS build

RUN mkdir ./app

# Resolve app dependencies.
WORKDIR /app
COPY ./ /app
RUN dart pub get