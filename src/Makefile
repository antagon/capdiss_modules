MAKE_PKG = ../utils/make_pkg.sh
MAKE_MD5SUMS = ../utils/make_md5sums.sh

PACKAGES = meta \
			core \
			print


.PHONY: all clean md5sums sign packages $(PACKAGES)

all:
	@echo "Run \`make packages\` or \`make clean\`"	

packages: $(PACKAGES) md5sums

core:
	$(MAKE_PKG) $@

print:
	$(MAKE_PKG) $@

meta:
	$(MAKE_PKG) $@

md5sums:
	$(MAKE_MD5SUMS) ./

sign:
	@gpg2 --detach-sign -u 484D301C MD5SUMS

clean:
	rm -f *.tar.gz
	rm -f *.rockspec
	rm -f *.rock
	rm -f *.sig
	rm -f MD5SUMS

