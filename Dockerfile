FROM golang:1.22.5 AS base

WORKDIR /app
COPY . .

#download modified dependencies
RUN go mod download 

#build the artifact
RUN go build -o main .

#final stage image
FROM gcr.io/distroless/base

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
