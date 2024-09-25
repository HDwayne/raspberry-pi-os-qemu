#ifndef	_MM_H
#define	_MM_H

#define PAGE_SHIFT      12  // Each page is 2^12 = 4KB = 4096 bytes
#define TABLE_SHIFT     9   // Each table has 2^9 = 512 entries
#define SECTION_SHIFT   (PAGE_SHIFT + TABLE_SHIFT)  //  Each section is 2^21 = 2MB = 2097152 bytes

#define PAGE_SIZE       (1 << PAGE_SHIFT)       // size of a page = 4KB. (1<<12 = 4096)
#define SECTION_SIZE    (1 << SECTION_SHIFT)    // size of a section = 2MB. (1<<21 = 2097152)

#define LOW_MEMORY      (2 * SECTION_SIZE)  // Address of the end of the first 4MB of memory. (2 * 2MB = 4MB = 0x400000)

#ifndef __ASSEMBLER__

void memzero(unsigned long src, unsigned long n);

#endif

#endif  /*_MM_H */
