path_to_service_proto=echo/echo.proto
output_dir=./

function generate() {
  protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --go_out=plugins=grpc:$output_dir \
  $path_to_service_proto
}

command=$1

case $command in
  gen)
    generate $2
    ;;
  *)
    echo "Command not found"
    ;;
esac