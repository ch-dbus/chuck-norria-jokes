## We specify the base image we need for our
## go application
FROM golang:1.18.1-alpine AS Builder
## We create an /app directory within our
## image that will hold our application source
## files
RUN mkdir /app
## We copy everything in the root directory
## into our /app directory
ADD . /app
## We specify that we now wish to execute
## any further commands inside our /app
## directory
WORKDIR /app
#COPY go.mod
#COPY go.sum
#RUN go mod download
## we run go build to compile the binary
## executable of our Go program
RUN go build -o main .

FROM alpine AS production

COPY --from=builder /app .
## Our start command which kicks off
## our newly created binary executable
CMD ["./main"]