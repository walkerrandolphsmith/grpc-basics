
# Getting Started

gRPC is a Remote Procedure Call (RPC) framework based on protobufs and HTTP/2. We want to generate a gRPC API and Rest API from a single protobuf `.proto` file compiled with a Protocol Buffer compiler, `protoc`.

## Installation

1) Install Golang
2) Include `$GOPATH/bin` in `$PATH`
3) Install protobuf
4) Install grpc-gateway packages

We need to first install the compiler
```
brew install protobuf
```

We also need the grpc-gateway packages
```
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
go get -u github.com/golang/protobuf/protoc-gen-go
```

## Code Generation

```
./ctl.sh generate
```

## Verify

```
./ctl.sh test
```

View the api docs here

<a href="http://localhost:8080/swagger-ui/#!/EchoService/Echo">http://localhost:8080/swagger-ui/#!/EchoService/Echo</a>