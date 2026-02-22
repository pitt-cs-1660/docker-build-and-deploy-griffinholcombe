FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates ./templates

RUN go mod download

RUN CGO_ENABLED=0 go build -o bandnames .

FROM scratch

WORKDIR /app

COPY --from=builder /app/bandnames .
COPY --from=builder /app/templates ./templates

ENTRYPOINT ["./bandnames"]