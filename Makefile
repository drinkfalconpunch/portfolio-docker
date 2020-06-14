# Basic go commands, https://sohlich.github.io/post/go_makefile/
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get

BINARY_NAME=portfolio

ifeq ($(OS),Windows_NT)
    detected_OS := Windows
	BINARY_NAME += .EXE
else
    detected_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

all: build

build: *.go
	$(GOBUILD) -o $(BINARY_NAME) -v

# for testing os version
os:
	@echo $(detected_OS)

clean:
	$(GOCLEAN) -i
	rm $(BINARY_NAME)

fmt:
	gofmt -w .