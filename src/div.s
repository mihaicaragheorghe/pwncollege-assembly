# speed = distance / time, where:
#   distance = rdi
#   time = rsi
#   speed = rax
#
# rax = rdi / rsi

.intel_syntax noprefix
.global _start
_start:
mov rax, rdi
mov rdx, 0
div rsi
