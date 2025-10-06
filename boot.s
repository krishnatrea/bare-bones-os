/* what is these variables? 
constants for the multiboot header.
if I wnt to load the os on the multiboot 
it should at least have these constant associated to it.

*/
.set ALIGN, 	1<<0 /* Align loaded modules on page boundries */
.set MEMINFO, 	1<<1 /* Ask for memory map from the OS. */
.set FLAGS, 	ALIGN | MEMINFO /* FLAG that will contain ALIGN and MEMINFO */ 
.set MAGIC, 	0x1BADB002 /* Magic number for bootloader to find header */
.set CHECKSUM,	-(MAGIC + FLAGS) /*checksum as to prove that we are mutiboot, as MEGIC + FLAGS + CHECKSUM = 0 */

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM


.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top: 

.section .text 
.global _start 
.type _start, @function 
_start:
    mov $stack_top, %esp 
    call kernel_main 
    cli
1:  hlt
    jmp 1b 

.size _start, . - _start 
