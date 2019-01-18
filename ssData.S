	.arch armv8-a
	.file	"ssData.S"
	.text

// long ss_read(const long token_top, const long token_bottom, slong regNo);
	.align	2
	.global	ss_read
	.type	ss_read, %function
ss_read:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 24]
	ldr	x0, [x4]
	ret
	.size	ss_read, .-ss_read

// long ss_saveCleanV(const long token_top, const long token_bottom, slong regNo);
	.align	2
	.global	ss_saveCleanV
	.type	ss_saveCleanV, %function
ss_saveCleanV:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 32]
	ldr x0, [x4]
	ret
	.size	ss_saveCleanV, .-ss_saveCleanV

// long ss_readV(const long token_top, const long token_bottom, slong regNo);
	.align	2
	.global	ss_readV
	.type	ss_readV, %function
ss_readV:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 40]
	ldr	x0, [x4]
	ret
	.size	ss_readV, .-ss_readV

// long ss_saveM(const long token_top, const long token_bottom, slong nrRegs);		// for debugging
	.align	2
	.global	ss_saveM
	.type	ss_saveM, %function
ss_saveM:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 48]
	ldr	x0, [x4]
	ret
	.size	ss_saveM, .-ss_saveM

// long ss_readM(const long token_top, const long token_bottom, slong nrRegs);	// for debugging
	.align	2
	.global	ss_readM
	.type	ss_readM, %function
ss_readM:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 56]
	ldr	x0, [x4]
	ret
	.size	ss_readM, .-ss_readM

// long ss_write(const long token_top, const long token_bottom, slong regNo);
	.align	2
	.global	ss_write
	.type	ss_write, %function
ss_write:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 64]
	ldr	x0, [x4]
	ret
	.size	ss_write, .-ss_write

// long ss_tell();;
	.align	2
	.global	ss_tell
	.type	ss_tell, %function
ss_tell:
	adrp	x0, ss_readV
	add	x0, x0, :lo12:ss_readV
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 80]
	ldr	x0, [x4]
	ret
	.size	ss_tell, .-ss_tell

/*
 * ss_start() is a very special function that does not follow ARM's calling convention
 * uuid_top, uuid_bottom, and LR are passed through x13, x14, x15
 * x12 is the clobber register
 * Also, it retuns meaningless thing. I keep it returns  garbage (garbage to the caller) because I'm lazy...
 */ 
// long ss_start();
	.align	2
	.global	ss_start
	.type	ss_start, %function
ss_start:
	adrp	x12, __channel_access
	add	x12, x12, :lo12:__channel_access
	ldr	x12, [x12, 8]
	ldr	x12, [x12]
	ret
	.size	ss_start, .-ss_start

/*
 * Like ss_start(), it retuns meaningless thing. I keep it returns  garbage (garbage to the caller) because I'm lazy...
 */
// long ss_exit();
	.align	2
	.global	ss_exit
	.type	ss_exit, %function
ss_exit:
	adrp	x4, __channel_access
	add	x4, x4, :lo12:__channel_access
	ldr	x4, [x4, 16]
	ldr	x0, [x4]
	ret
	.size	ss_exit, .-ss_exit

	.type	.L.str.3,@object        // @.str.3

	.ident	"GCC: (Linaro GCC 6.2-2016.11) 6.2.1 20161016"
	.section	.note.GNU-stack,"",@progbits