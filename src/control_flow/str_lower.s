.intel_syntax noprefix
.global _start
_start:
    xor     rcx, rcx        # i = 0
    mov     rsi, rdi
    mov     rdx, 0x403000   # foo
    cmp     rsi, 0          # if src_addr != 0
    je      _end            # jump to end if src_addr is 0

_loop:
    mov     bl, [rsi]       # load byte at src_addr into bl
    cmp     bl, 0           # check if [src_addr] != 0x00
    je      _end            # jump to end if null terminator

    cmp     bl, 0x5a        # compare [src_addr] with 0x5a ('Z')
    ja      _next           # if [src_addr] > 'Z', skip foo

    mov     rdi, [rsi]      # foo's argument ([src_addr])
    call    rdx             # call foo
    mov     [rsi], al       # move result back into [src_addr]

    add     rcx, 1          # i += 1

_next:
    add     rsi, 1          # src_addr += 1
    jmp     _loop           # repeat the loop

_end:
    mov     rax, rcx        # move i into rax to return
    ret                     # return i

# str_lower(src_addr):
#   i = 0
#   if src_addr != 0:
#     while [src_addr] != 0x00:
#       if [src_addr] <= 0x5a:
#         [src_addr] = foo([src_addr])
#         i += 1
#       src_addr += 1
#  return i
