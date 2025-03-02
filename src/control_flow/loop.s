.intel_syntax noprefix
.global _start
_start:
    mov rax, 0  # sum = 0
    mov rbx, 0  # i = 0
    cmp rsi, 0  # compare n and 0
    je DONE     # if n == 0 goto DONE
    jge LOOP    # else if n >= 0 goto LOOP

LOOP:
    add rax, [rdi + rbx * 8]    # add current qword to result
    inc rbx                     # i++
    cmp rbx, rsi                # compare i and n
    jl LOOP                     # if i <= n goto LOOP

    xor rdx, rdx                # clear rdx for division
    div rsi                     # sum / n

DONE:

# sum = 0
# i = 1
# while i <= n:
#     sum += [k]
#     i++
#
# res = sum / n