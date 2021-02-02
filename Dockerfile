FROM golang:1.14-alpine3.11 as builder

WORKDIR /go/src/github.com/alicebob/asprom/

RUN apk add --no-cache git make \
    && git clone --branch v1.10.1 https://github.com/alicebob/asprom.git .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o asprom .

FROM alpine:3.11
LABEL org.opencontainers.image.source https://github.com/okgolove/docker-asprom

RUN apk --no-cache add ca-certificates

WORKDIR /opt/asprom

COPY --from=builder /go/src/github.com/alicebob/asprom/asprom .

CMD ["./asprom"]
