ARCH=arm64
CROSS_COMPILE=../toolchains/aarch64/bin/aarch64-linux-gnu-

CC      = $(CROSS_COMPILE)gcc
LD      = $(CROSS_COMPILE)ld
AR      = $(CROSS_COMPILE)ar
NM      = $(CROSS_COMPILE)nm
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
READELF = $(CROSS_COMPILE)readelf

OBJS = slib.o

CFLAGS += -Wall

ARCHIVE = slib

.PHONY: all
all: $(ARCHIVE)

$(ARCHIVE): $(OBJS)
	$(AR) rcs $@.a $<