.intel_syntax noprefix
.global _start
_start:
    mov rbp, rsp            # stack_base
    sub rsp, 0xff           # allocate space for array
    mov rax, 0              # i = 0
    sub rsi, 1              # size - 1

_loop1:
    # if i > size - 1 goto end1
    cmp rax, rsi
    jg _end1               

    # curr_byte = [src_addr + i]
    xor rcx, rcx
    mov cl, [rdi + rax]

    # [stack_base - curr_byte] += 1
    mov rdx, rbp            # store stack_base into rdx
    sub rdx, rcx            # subtract curr_byte (rcx)
    mov r11, [rdx]          # store the address of the result in r11
    inc r11                 # increment it
    mov [rdx], r11          # assign the result to the address at rdx, which is stack_base - curr_byte

    inc rax                 # i += 1
    jmp _loop1              # repeat

_end1:
    mov rcx, 1              # b = 1
    mov rbx, 0              # max_freq = 0
    mov rax, 0              # max_freq_byte = 0

_loop2:
    # if b > 0xfd goto end2
    cmp rcx, 0xff
    jg _end2

    # [stack_base - b]
    mov r11, rbp            # store stack_base into r11
    sub r11, rcx            # subtract b from it
    mov r8b, [r11]          # store [stack_base - b] in r8b

    # if [stack_base - b] <= max_freq skip
    cmp r8b, bl
    jbe skip

    mov bl, r8b             # max_freq = [stack_base - b]
    mov rax, rcx            # max_freq_byte = b

skip:
    inc rcx                 # b += 1
    jmp _loop2              # repeat

_end2:
    mov rsp, rbp            # restore allocated space
    ret

# most_common_byte(src_addr, size):
#   i = 0
#   while i <= size-1:
#     curr_byte = [src_addr + i]
#     [stack_base - curr_byte] += 1
#     i += 1
# 
#   b = 0
#   max_freq = 0
#   max_freq_byte = 0
#   while b <= 0xff:
#     if [stack_base - b] > max_freq:
#       max_freq = [stack_base - b]
#       max_freq_byte = b
#     b += 1
# 
#   return max_freq_byte
