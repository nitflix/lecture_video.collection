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

project_name ?= $(PROJECT_NAME)
batch ?= $(BATCH)
interface = docker compose --project-name $(project_name)-$(batch) run -d queue
download:
	COURSE_HREF=$(COURSE_HREF) VIDEO_TITLE=$(VIDEO_TITLE) $(interface)

