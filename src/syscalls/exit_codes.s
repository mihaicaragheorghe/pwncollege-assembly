.intel_syntax noprefix
.global _start
_start:
mov rdi, 42 # the first parameter received by the syscall
mov rax, 60 # the syscall index, exit in this case, which receive the exit code parameter
syscall     # execute the syscall
