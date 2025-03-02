.intel_syntax noprefix
.global _start
_start:
    mov rdi, 1          # first arg
    mov rsi, 1337000    # second arg
    mov rdx, 1          # third arg
    mov rax, 1          # syscall index for write
    syscall

# C:
# write(0, 1337000, 1);
