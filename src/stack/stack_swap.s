.intel_syntax noprefix
.global _start
_start:
push rdi   # pushes 2
push rsi   # pushes 5 on top of the 2
pop rdi    # pops 5 into rdi → rdi becomes 5
pop rsi    # pops 2 into rsi → rsi becomes 2
