#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#define __GINSENG_SLIB
#include "slib.h"
#include "schannel_svc.h"
// #include <stdio.h>
#define pagesize 4096
#ifdef USE_INIT
struct __addresses __channel_access = { .bInited = 0 };
static char *_mmap(int fd, off_t paddr) {
    off_t page_base = (paddr / pagesize) * pagesize;
    off_t page_offset = paddr - page_base;
    return (char *) mmap(NULL, page_offset + 1, 
     									PROT_READ | PROT_WRITE, MAP_PRIVATE, 
     									fd, page_base);
}

#define errNo 0
int ss_init() {
	if (__channel_access.bInited) return 1;

    int fd = open("/dev/mem", O_SYNC);
    if (fd < 0) {
    	return errNo;
    }

    __channel_access.pSSStart = _mmap(fd, SCHANNEL_CMD_ENTRY << SCHANNEL_CMD_SHIFT);
    if (__channel_access.pSSStart == (void *) -1) {
    	return errNo;
    }

	__channel_access.pSSExit = _mmap(fd, SCHANNEL_CMD_EXIT << SCHANNEL_CMD_SHIFT);
	if (__channel_access.pSSExit == (void *) -1) {
		return errNo;
	}

	__channel_access.pSSRead = _mmap(fd, SCHANNEL_CMD_READ << SCHANNEL_CMD_SHIFT);
	if (__channel_access.pSSRead == (void *) -1) {
		return errNo;
	}

	__channel_access.pSSSaveCleanV = _mmap(fd, SCHANNEL_CMD_SAVE_CLEAN_V << SCHANNEL_CMD_SHIFT);
	if (__channel_access.pSSSaveCleanV == (void *) -1) {
		return errNo;
	}

	__channel_access.pSSReadV = _mmap(fd, SCHANNEL_CMD_READ_V << SCHANNEL_CMD_SHIFT);
	if (__channel_access.pSSReadV == (void *) -1) {
		return errNo;
	}

	__channel_access.pSSSaveM = _mmap(fd, SCHANNEL_CMD_SAVE_M << SCHANNEL_CMD_SHIFT);
	if (__channel_access.pSSSaveM == (void *) -1) {		// for debugging
		return errNo;
	}
	
	__channel_access.pSSReadM = _mmap(fd, SCHANNEL_CMD_READ_M << SCHANNEL_CMD_SHIFT);
	if (__channel_access.pSSReadM == (void *) -1) {		// for debugging
		return errNo;
	}

	__channel_access.pSSWrite = _mmap(fd, SCHANNEL_CMD_SAVE << SCHANNEL_CMD_SHIFT);;
	if (__channel_access.pSSWrite == (void *) -1) {
		return errNo;
	}
	__channel_access.pSSTell = _mmap(fd, SCHANNEL_CMD_TELL << SCHANNEL_CMD_SHIFT);;
	if (__channel_access.pSSTell == (void *) -1) {
		return errNo;
	}

	ss_tell();
    __channel_access.bInited = 1;
    return 0;
}
#endif
