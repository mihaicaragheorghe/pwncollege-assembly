.intel_syntax noprefix
.global _start
_start:
mov rax, [rsp]
add rax, [rsp+8]
add rax, [rsp+16]
add rax, [rsp+24]
mov rcx, 4
div rcx
push rax

# On x86, the stack pointer is stored in the special register, rsp.
# rsp always stores the memory address of the top of the stack, i.e., the memory address of the last value pushed.
#
# This program will get the top qword on the stack and next 3 qwords and calculate their average