#ifndef __GINSENG_SLIB_H
#define __GINSENG_SLIB_H

#include <schannel.h>

#define __stringfy(a)   ___stringfy(a)
#define ___stringfy(a)   #a  
#define slong long __attribute__((annotate("SS_DATA")))

#define USE_INIT

#ifdef USE_INIT
int ss_init();
struct __addresses { /* debug included */
	int bInited;			// 0
	// slib functions
	char *pSSStart;			// 8
	char *pSSExit;			// 16
	char *pSSRead;			// 24
	char *pSSSaveCleanV;	// 32
	char *pSSReadV;			// 40
	char *pSSSaveM;			// 48
	char *pSSReadM;			// 56
	char *pSSWrite;			// 64
	char *pSSCFGCheck;		// 72
	char *pSSTell;			// 80
};
extern struct __addresses __channel_access;
#endif

long ss_start();
long ss_exit();

long ss_read(const long token_top, const long token_bottom, slong regNo);
long ss_write(const long token_top, const long token_bottom, slong regNo);
long ss_saveCleanV(const long token_top, const long token_bottom, slong regNo, long bFuncPtr);
long ss_readV(const long token_top, const long token_bottom, slong regNo);
long ss_tell();
long ss_saveM(const long token_top, const long token_bottom, slong nrRegs);	// for debugging
long ss_readM(const long token_top, const long token_bottom, slong nrRegs);	// for debugging

#endif