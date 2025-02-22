.intel_syntax noprefix
.global _start
_start:
mov [133700], 42
mov rax, 133700  # after this, rax will be 133700
mov rax, [rax]   # after this, rax will be 42
mov rax, 60
syscall
