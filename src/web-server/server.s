.intel_syntax noprefix
.global _start
.section .text

_start:

socket:
    mov rdi, 2      # AF_INET
    mov rsi, 1      # SOCK_STREAM
    mov rdx, 0      # Protocol, 0 for default
    mov rax, 41     # syscall for socket(2, 1, 0)
    syscall

    test rax, rax   # check if socket() failed
    js exit_fail    # exit if failed
    mov rdi, rax    # save the sockfd, bind will use it

bind:

# Construct and push sockaddr_in structure onto the stack
    sub rsp, 16                             # Allocate space on the stack, size of sockaddr_in
    mov word ptr  [rsp], 2                  # sin_family = AF_INET (2)
    mov word ptr  [rsp+2], 0x5000           # sin_port = htons(80)
    mov dword ptr [rsp+4], 0x00000000       # sin_addr = 0.0.0.0
    mov qword ptr [rsp+8], 0                # sin_zero = 0 (unused padding)

    mov rsi, rsp                            # pointer to sockaddr_in
    mov rdx, 16                             # size of sockaddr_in (16)
    mov rax, 49                             # syscall for bind(<sockfd>, sockaddr_in { sin_family = 2, sin_port = htons(80), sin_addr = 0.0.0.0, sin_zero = 0 })
    syscall

    add rsp, 16                             # Clean up sockaddr_in (pop 16 bytes)

    test rax, rax
    js exit_fail

listen:
    mov rsi, 0                  # backlog, max pending connections queue
    mov rax, 50                 # syscall for listen(<sockfd>, 0)
    syscall

    test rax, rax
    js exit_fail

accept:
    mov rsi, 0x00       # NULL
    mov rdx, 0x00       # NULL
    mov rax, 43         # syscall for accept(3, NULL, NULL)
    syscall

    test rax, rax
    js exit_fail

    mov rdi, rax        # The sockfd for the connection

read:
    lea rsi, read_buffer
    mov rdx, 1024
    mov rax, 0
    syscall

    test rax, rax
    js exit_fail

write:
    lea rsi, write_static
    mov rdx, 19
    mov rax, 1
    syscall

    test rax, rax
    js exit_fail

close:
    mov rax, 3
    syscall

# exit(0)
exit_success:
    mov rax, 60
    mov rdi, 0
    syscall

# exit(1)
exit_fail:
    mov rax, 60
    mov rdi, 1
    syscall

.section .data
    read_buffer: .space 1024
    write_static: .string "HTTP/1.0 200 OK\r\n\r\n"
