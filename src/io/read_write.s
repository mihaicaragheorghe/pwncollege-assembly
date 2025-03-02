.intel_syntax noprefix
.global _read

_read:
    mov rdi, 0          # first arg
    mov rsi, 1337000    # second arg
    mov rdx, 8          # third arg
    mov rax, 0          # syscall read
    syscall

write:
    mov rdi, 1
    mov rsi, 1337000
    mov rdx, 8
    mov rax, 1      # syscall write
    syscall

exit:
    mov rdi, 42
    mov rax, 60     # syscall exit
    syscall

# read(0, 1337000, 5);
# This will read 5 bytes from file descriptor 0 (stdin) into memory starting from 1337000. So, if you type in (or pipe in) HELLO HACKERS into stdin, the above read call would result in the following memory configuration:
# 
#   Address │ Contents
# +────────────────────+
# │ 1337000 │ 48       │
# │ 1337001 │ 45       │
# │ 1337002 │ 4c       │
# │ 1337003 │ 4c       │
# │ 1337004 │ 51       │
# +────────────────────+
#
# write(0, 1337000, 5);
# exit(42);
