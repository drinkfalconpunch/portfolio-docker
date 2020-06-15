# Build source

FROM golang:alpine as build

RUN apk add --no-cache alpine-sdk

WORKDIR /app

RUN git clone https://www.github.com/drinkfalconpunch/portfolio-docker.git

COPY . .

RUN make

# Run portfolio server

FROM alpine:latest

ARG PORT_NUMBER=8080

WORKDIR /app

COPY --from=build /app .

EXPOSE ${PORT_NUMBER}

CMD ["sh", "-c", "/app/portfolio ${PORT_NUMBER}"]