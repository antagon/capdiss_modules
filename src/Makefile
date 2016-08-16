MAKE_PKG = ../utils/make_pkg.sh
MAKE_MD5SUMS = ../utils/make_md5sums.sh

PACKAGES = core\
			print

.PHONY: md5sums packages $(PACKAGES)

all:
	@echo "Run \`make packages\` or \`make clean\`"	

md5sums:
	@$(MAKE_MD5SUMS) ./

packages: $(PACKAGES)

core:
	@$(MAKE_PKG) $@

print:
	@$(MAKE_PKG) $@

clean:
	rm -f *.tar.gz
	rm -f *.rockspec
	rm -f MD5SUMS

