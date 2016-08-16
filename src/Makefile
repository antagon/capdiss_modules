include ../Makefile.defs

PACKAGES = core\
			print

.PHONY: packages $(PACKAGES)

all:
	@echo "Run \`make packages\` or \`make clean\`"	

packages: $(PACKAGES)

core:
	@$(MAKE_PKG) $@

print:
	@$(MAKE_PKG) $@

clean:
	rm -f *.tar.gz
	rm -f *.rockspec

