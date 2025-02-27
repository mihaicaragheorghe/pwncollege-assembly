.intel_syntax noprefix
.global _start
_start:

# Shift rdi right by 32 bits to bring the 5th byte to the least significant position
shr rdi, 32

# Mask out any remaining bits to ensure only that byte is kept in rax
shl rdi, 56 
shr rdi, 56
mov rax, rdi
