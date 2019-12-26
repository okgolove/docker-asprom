FROM golang:1.12.5-alpine3.9 as builder

WORKDIR /go/src/github.com/alicebob/asprom/

RUN apk add --no-cache git make && \
    git clone --branch v1.7.0 https://github.com/alicebob/asprom.git .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o asprom .

FROM alpine:3.9

RUN apk --no-cache add ca-certificates

WORKDIR /opt/asprom

COPY --from=builder /go/src/github.com/alicebob/asprom/asprom .

CMD ["./asprom"]
