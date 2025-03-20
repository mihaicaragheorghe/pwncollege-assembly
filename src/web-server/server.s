.intel_syntax noprefix
.global _start
.section .text

_start:

socket:
    mov rdi, 2                              # int domain -> 2(AF_INET)
    mov rsi, 1                              # int type -> 1(SOCK_STREAM)
    mov rdx, 0                              # int protocol, 0 for default
    mov rax, 41                             # socket(2, 1, 0)
    syscall

    test rax, rax                           # check if socket() failed
    js exit_fail                            # exit if failed
    mov r9, rax                             # save the sockfd for reuse

bind:

    # Construct and push sockaddr_in structure onto the stack
    sub rsp, 16                             # Allocate space on the stack, size of sockaddr_in
    mov word ptr  [rsp], 2                  # sin_family = AF_INET (2)
    mov word ptr  [rsp+2], 0x5000           # sin_port = htons(80)
    mov dword ptr [rsp+4], 0x00000000       # sin_addr = 0.0.0.0
    mov qword ptr [rsp+8], 0                # sin_zero = 0 (unused padding)

    mov rdi, r9                             # sockfd returned by socket()
    mov rsi, rsp                            # pointer to sockaddr_in
    mov rdx, 16                             # size of sockaddr_in (16)
    mov rax, 49                             # bind(<sockfd>, sockaddr_in { sin_family = 2, sin_port = htons(80), sin_addr = 0.0.0.0, sin_zero = 0 }, 16)
    syscall

    add rsp, 16                             # Clean up sockaddr_in (pop 16 bytes)

    test rax, rax
    js exit_fail

listen:
    mov rdi, r9                             # sockfd
    mov rsi, 0                              # backlog, max pending connections queue
    mov rax, 50                             # listen(<sockfd>, 0)
    syscall

    test rax, rax
    js exit_fail

accept:
    mov rdi, r9                             # sockfd
    mov rsi, 0x00                           # struct sockaddr *_Nullable restrict addr -> NULL
    mov rdx, 0x00                           # socklen_t *_Nullable restrict addrlen -> NULL
    mov rax, 43                             # accept(3, NULL, NULL)
    syscall

    test rax, rax
    js exit_fail

    mov r10, rax                            # Save connection sockfd in r10 for later use

fork:
    mov rdi, r10                            # connection sockfd returned by accept
    mov rsi, rdi                            # save sockfd for the child process
    mov rax, 57                             # syscall fork
    syscall

    test rax, rax
    js exit_fail                            # fork failed
    jz child                                # 0 is returned in the child
    jnz parent                              # pid of the child is returned to the parent

parent:
    jmp close_sock

child:
    # Close the socket
    mov rdi, r9
    mov rax, 3
    syscall

    # Use the connection socked
    mov rdi, rsi

read:
    lea rsi, req_buffer                 # the buffer to read into
    mov rdx, 1024                       # buffer size
    mov rax, 0                          # syscall for read
    syscall

    test rax, rax
    js exit_fail

# Find first space (skip "GET ")
find_first_space:
    mov al, byte [rsi]
    cmp al, ' '
    je path_start_found
    inc rsi
    jmp find_first_space

path_start_found:
    add rsi, 2                          # move to first char of path, todo: find out why 2 is working and 1 not
    mov rbx, rsi                        # save start_ptr of path

# Find second space (end of path)
find_second_space:
    mov al, byte [rsi]
    cmp al, ' '
    je path_end_found
    inc rsi
    jmp find_second_space

path_end_found:
    mov rcx, rsi                        # end_ptr
    sub rcx, rbx                        # rcx = length of path

open_file:
    mov byte ptr [rbx + rcx + 1], 0     # null terminate the path, ?this should work without the +1
    mov rdi, rbx                        # file path
    mov rsi, 0                          # O_RDONLY
    mov rax, 2                          # syscall open
    syscall

    test rax, rax
    js exit_fail


read_file:
    mov rdi, rax                        # the file description returned by open()
    lea rsi, file_buffer                # the buffer to read into
    mov rdx, 2048                       # buffer size
    mov rax, 0                          # syscall for read
    syscall

    test rax, rax
    js exit_fail

    mov r13, rax                        # number of bytes read from file

close_file:
    mov rax, 3
    syscall

write_headers:
    mov rdi, r10                        # sockfd of the connection
    lea rsi, write_static               # the buffer to write from
    mov rdx, 19                         # the size of the buffer
    mov rax, 1                          # write syscall
    syscall

    test rax, rax
    js exit_fail

write_content:
    mov rdi, r10                        # sockfd of the connection
    lea rsi, file_buffer                # pointer to the read buffer
    mov rdx, r13                        # number of bytes read from file returned by the syscall
    mov rax, 1                          # write syscall
    syscall

    test rax, rax
    js exit_fail
    jmp exit_success

close_sock:
    mov rax, 3
    syscall
    jmp accept

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
    req_buffer: .space 1024
    file_buffer: .space 2048
    write_static: .string "HTTP/1.0 200 OK\r\n\r\n"
