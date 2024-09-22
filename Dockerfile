FROM golang:1.22.5 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY  . .
RUN GOARCH=amd64 GOOS=linux go build -o main .


#Now starts the distroless image creation

FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD [ "./main" ]
