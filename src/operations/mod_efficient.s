.intel_syntax noprefix
.global _start
_start:
mov al, dil
mov bx, si

# We can use a math trick to optimize the modulo operator (%). Compilers use this trick a lot.
# If we have x % y, and y is a power of 2, such as 2^n, the result will be the lower n bits of x.
# Therefore, we can use the lower register byte access to efficiently implement modulo!
#
# rax = rdi % 256
# rbx = rsi % 65536
