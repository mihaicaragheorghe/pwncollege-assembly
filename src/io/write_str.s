.intel_syntax noprefix
.global _start
_start:
    mov rdi, 1          # first arg
    mov rsi, 1337000    # second arg
    mov rdx, 14         # third arg
    mov rax, 1          # syscall index for write
    syscall

    mov rdi, 42
    mov rax, 60
    syscall

# This will call write(file_descriptor, memory_address, number_of_characters_to_write) with the following arguments
#
# write(1, 133700, 14);
# exit(42);