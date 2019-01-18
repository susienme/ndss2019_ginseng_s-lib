CROSS_COMPILE=$(HIKEY_DIR)/toolchains/aarch64/bin/aarch64-linux-gnu-
ARCH=arm64

CC      = $(CROSS_COMPILE)gcc
LD      = $(CROSS_COMPILE)ld
AR      = $(CROSS_COMPILE)ar
NM      = $(CROSS_COMPILE)nm
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
READELF = $(CROSS_COMPILE)readelf

#OBJS = slib.o

CFLAGS += -Wall -I$(HIKEY_DIR)/arm-trusted-firmware/include/bl31 -Wno-attributes

ARCHIVE = slib.a

.PHONY: all
all: asm $(ARCHIVE)

asm: slib.c
	$(CC) -S -o slib.S slib.c $(CFLAGS)

$(ARCHIVE): slib.c slib.h ssData.S
	$(CC) $(CFLAGS) -c -o slib.o slib.c
	$(CC) $(CFLAGS) -c -o ssData.o ssData.S
#	$(CC) $(CFLAGS) -S -o slib_test.S slib_test.c
	$(AR) rcs $@ slib.o ssData.o

test: asm slib.c slib.h slib_test.c
	$(CC) $(CFLAGS) -c -o slib.o slib.c
	$(CC) $(CFLAGS) -S -o slib_test.S slib_test.c
	$(CC) $(CFLAGS) -c -o slib_test.o slib_test.c
	$(AR) rcs slib_test.a slib.o slib_test.o

install:
	@echo "Don't need to install. Currently, a static lib."

.PHONY: clean
clean:
	rm -f $(OBJS) $(ARCHIVE)
