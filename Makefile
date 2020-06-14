ifeq ($(OS),Windows_NT)
    detected_OS := Windows
else
    detected_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

all: portfolio

portfolio: *.go
	GOOS=linux GOARCH=386 go$(GO_VERSION) build -o $@

# for testing os version
os:
	@echo $(detected_OS)

clean:
	rm portfolio

fmt:
	gofmt -w .