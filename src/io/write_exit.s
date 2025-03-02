.intel_syntax noprefix
.global _start
_start:
    mov rdi, 1          # first arg
    mov rsi, 1337000    # second arg
    mov rdx, 1          # third arg
    mov rax, 1          # syscall index for write
    syscall

    mov rdi, 42
    mov rax, 60     # syscall index for exit
    syscall

# write(0, 1337000, 1);
# exit(42);
