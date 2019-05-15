package main

import (
	"context"
	"log"
	"net"

	"google.golang.org/grpc"
	pb "github.com/walkerrandolphsmith/gRPC-basics/echo"
)

const (
	port = ":50051"
)

type server struct{}

func (s *server) Echo(ctx context.Context, in *pb.EchoMessage) (*pb.EchoMessage, error) {
	log.Printf("Received: %v", in.Value)
	return &pb.EchoMessage{Value: "Hello " + in.Value}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterEchoServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
