test:
	@echo "Run bundle and rspec after creating container"
	@echo "Before release, this target should be able to run rspec"
	@echo "instead of bash followed by bundle && rspec"
	@docker compose run test bash

youtube-dl\:development:
	docker build -t $@ -f Dockerfile.youtube-dl .

bin/rest-server:
	docker build -t rest-server -f Dockerfile.database .
	docker run -it --rm rest-server -w /work -v $(pwd)/rest-server:/work CGO_ENABLED=0 go build -o rest-server ./cmd/rest-server

interface = docker compose run -d queue
download:
	VIDEO_TITLE=$(TITLE) $(interface)

