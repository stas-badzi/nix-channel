current_dir = $(shell pwd)
dirname = $(shell basename $(current_dir))

ifeq ($(priv_key_file),)
	priv_key_file = $(k)
endif

_output\nixexprs.tar.gz: default.nix pkgs/*
	mkdir -p _output
	cd ..; tar -cJf $(dirname)/_output/nixexprs.tar.xz $(dirname)/default.nix $(dirname)/pkgs --owner=0 --group=0 --mtime="1970-01-01 00:00:00 UTC"

	nix-build
	nix store sign -k "$(priv_key_file)" "$$(realpath ./result)" --extra-experimental-features nix-command
	nix copy --to "file:///$$PWD/_output/cache" "$$(realpath ./result)" --extra-experimental-features nix-command

publish: _output\nixexprs.tar.gz
	cd $$(mktemp -d); git clone https://github.com/stas-badzi/stas-badzi.github.io.git; cd stas-badzi.github.io; cp -r $(current_dir)/_output/* .; git add .; git commit -m "nix-channel update"; git push

clean:
	rm -rf _output result