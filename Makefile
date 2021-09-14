copy:
	@if [ ! -d "./.vim" ]; then cp -r "$$HOME/.vim" ./.vim; fi

remove:
	@rm -rf ./.vim

build: copy
	@docker image build -t python-container-with-vim .

run: build
	@docker container run -it -v "$$(pwd)":/app python-container-with-vim /bin/bash

clean: remove_vim_files
	-@docker container rmi -f python-container-with-vim &> /dev/null || true

rebuild: clean run
