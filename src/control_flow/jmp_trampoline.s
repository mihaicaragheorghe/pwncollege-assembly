.intel_syntax noprefix
.global _start
_start:
    jmp target
    .rept 0x51
    nop
    .endr
target:
    mov rdi, [rsp]
    mov rax, 0x403000
    jmp rax

# Absolute jumps: jump to an absolute address in memory. (0x403000)
