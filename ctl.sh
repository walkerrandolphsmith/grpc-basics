path_to_service_proto=service.proto
output_dir=generated

function generateStub() {
  protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --go_out=plugins=grpc:$output_dir \
  $path_to_service_proto
}

function genreateReverseProxy() {
  protoc -I/usr/local/include -I. \
    -I$GOPATH/src \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --grpc-gateway_out=logtostderr=true:$output_dir \
    $path_to_service_proto
}

function generateSwagger() {
  protoc -I/usr/local/include -I. \
    -I$GOPATH/src \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --swagger_out=logtostderr=true:$output_dir \
    $path_to_service_proto
}

function generate() {
  if [ $# -eq 0 ]
  then
    generateStub
    genreateReverseProxy
    generateSwagger
  elif [ $1 == "stub" ]
  then
      generateStub
  elif [ $1 == "proxy" ]
  then
    genreateReverseProxy
  elif [ $1 == "swagger" ]
  then
    generateSwagger
  fi
}

function testRest() {
  curl -X POST -k http://localhost:8080/v1/echo \
    -H "Content-Type: text/plain" \
    -d '{"value": "foo"}'
}

function test() {
  if [ $1 == "rest" ]; then
      testRest
  fi
}

command=$1

case $command in
  test)
    test $2
    ;;
  gen)
    generate $2
    ;;
  *)
    echo "Command not found"
    ;;
esac