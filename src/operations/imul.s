# f(x) = mx + b, where:
#     m = rdi
#     x = rsi
#     b = rdx

.intel_syntax noprefix
.global _start
_start:
imul rdi, rsi
mov rax, rdi
add rax, rdx
