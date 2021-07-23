FROM golang:1.16.6-alpine3.14 as builder

WORKDIR /workspace

COPY . /workspace

RUN CGO_ENABLED=0 go test ./...
RUN CGO_ENABLED=0 GOOS=linux go build -o kube-sqs-autoscaler

FROM alpine:3.14

RUN apk add --no-cache --update ca-certificates

COPY --from=builder /workspace/kube-sqs-autoscaler /

CMD ["/kube-sqs-autoscaler"]
