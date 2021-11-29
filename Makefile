#
# Linux kernel C++ module makefile
# Oleg Kutkov, 2019
#

MOD_NAME    := cpp_kernel
KERNEL      := /lib/modules/$(shell uname -r)/build
FLAGS       := -Wall
KMOD_DIR    := $(shell pwd)

OBJECTS := module.o \
		kern_lib.o \
		logger.o \
		cpp_support.cpp.o \
		cpp_module.cpp.o

ccflags-y += $(FLAGS)

# Apply C flags to the cpp compiler and disable cpp features that can't be supported in kernel module

cxx-selected-flags = $(shell echo $(KBUILD_CFLAGS) \
            | sed s/-D\"KBUILD.\"//g \
            | sed s/-Wstrict-prototypes//g \
            | sed s/-Wdeclaration-after-statement//g \
            | sed s/-Wno-pointer-sign//g \
            | sed s/-std=gnu90//g)

cxxflags = $(FLAGS) \
            $(cxx-selected-flags) \
            -fno-builtin \
            -nostdlib \
            -fno-rtti \
            -fno-exceptions \
            -std=c++0x


obj-m += $(MOD_NAME).o

$(MOD_NAME)-y := $(OBJECTS)

.PHONY: $(MOD_NAME).ko
$(MOD_NAME).ko:
	@echo building module
	make -C $(KERNEL) M=$(KMOD_DIR) modules

#cxx-prefix := " $(HOSTCXX) [M]  "
cxx-prefix := " $(HOSTCXX) [M] "


%.cpp.o: %.cpp
	@echo $(cxx-prefix)$@
	@$(HOSTCXX) $(cxxflags) -c $< -o $@

.PHONY: clean
clean:
	@echo clean
	make -C $(KERNEL) M=$(KMOD_DIR) clean
