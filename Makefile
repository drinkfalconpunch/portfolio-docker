# Basic go commands, https://sohlich.github.io/post/go_makefile/
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get

DOCKER=docker
DOCKERBUILD=$(DOCKER) build
DOCKERRM=$(DOCKER) rm
DOCKERRUN=$(DOCKER) run

BINARY_NAME=portfolio
PORT_NUMBER=9000

ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
	BINARY_NAME += .EXE
else
    DETECTED_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

all: build

build: *.go
	$(GOBUILD) -o $(BINARY_NAME) -v

# for testing os version
os:
	@echo $(DETECTED_OS)

clean:
	$(GOCLEAN) -i
	rm $(BINARY_NAME)
	$(DOCKERRM) --force $(BINARY_NAME)

docker: build
	$(DOCKERBUILD) -t $(BINARY_NAME) .
	$(DOCKERRUN) -d -p $(PORT_NUMBER):$(PORT_NUMBER) -e "PORT_NUMBER=$(PORT_NUMBER)" $(BINARY_NAME)

fmt:
	gofmt -w .