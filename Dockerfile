ARG GO_VERSION=1.23.4

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION} AS build

WORKDIR /src
COPY . .

# Download dependencies as a separate step to take advantage of Docker's caching.
RUN go mod download -x

# Build the application.
RUN go build -o /app/omada .

# Expose the port that the application listens on.
EXPOSE 4200

# What the container should run when it is started.
ENTRYPOINT [ "/app/omada" ]