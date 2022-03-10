test:
	@echo "Run bundle and rspec after creating container"
	@echo "Before release, this target should be able to run rspec"
	@echo "instead of bash followed by bundle && rspec"
	@docker compose run test bash
