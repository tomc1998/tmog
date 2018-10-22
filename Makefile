os=
ifeq ($(shell uname -s),Darwin)
	os=osx
endif

GLFW_LIB=$(LIBDIR)/libglfw3.a

SRCDIR=src
BINDIR=bin
LIBDIR=lib
DEPDIR=dep
CMAKE=cmake
SRC=$(shell find src -type f)

ALL: $(ALL_DIRS)
	$(info Targets: run clean (cleans built objects), clean-all (cleans dependencies and built objects))

ALL_DIRS=$(SRCDIR) $(BINDIR) $(LIBDIR) $(DEPDIR) $(DEPDIR)/tmp/
$(ALL_DIRS):
	mkdir -p $@

.PHONY: run
.PHONY: clean
.PHONY: clean-all

clean:
	rm -rf $(BINDIR)

clean-all:
	rm -rf $(BINDIR)
	rm -rf $(LIBDIR)
	rm -rf $(DEPDIR)

run: $(ALL_DIRS) $(BINDIR)/main
	$(BINDIR)/main

$(BINDIR)/main: $(GLFW_LIB) $(SRC)
	terra $(SRCDIR)/main.t

################
# Dependencies #
################

$(LIBDIR)/libenet.a:
	if [ ! -d $(DEPDIR)/enet ] ; then \
		git clone https://github.com/lsalzman/enet $(DEPDIR)/enet ; \
	fi
	mkdir -p $(DEPDIR)/enet/build
	cd $(DEPDIR)/enet/build && cmake .. && make
	mv $(DEPDIR)/enet/build/libenet.a $@

$(GLFW_LIB):
	if [ ! -d $(DEPDIR)/glfw ] ; then \
		git clone https://github.com/glfw/glfw $(DEPDIR)/glfw ; \
	fi
	mkdir -p $(DEPDIR)/glfw/build
	cd $(DEPDIR)/glfw/build ; \
	cmake .. -DGLFW_BUILD_EXAMPLES=OFF \
	         -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_DOCS=OFF -DGLFW_INSTALL=OFF ; \
	make
	mv $(DEPDIR)/glfw/build/src/$(notdir $@) $@
