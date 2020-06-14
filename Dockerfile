# Build source

FROM golang:alpine as build

RUN apk add --no-cache alpine-sdk

WORKDIR /app

RUN git clone https://www.github.com/drinkfalconpunch/portfolio-docker

RUN make

#COPY . .

# Run portfolio server

