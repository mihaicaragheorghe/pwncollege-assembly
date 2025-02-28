.intel_syntax noprefix
.global _start
_start:
    cmp rdi, 3
    ja default_case
    mov rax, [rsi + rdi * 8]
    jmp rax

default_case:
    mov rax, [rsi + 32]
    jmp rax

# if rdi is 0:
#   jmp 0x40301e
# else if rdi is 1:
#   jmp 0x4030da
# else if rdi is 2:
#   jmp 0x4031d5
# else if rdi is 3:
#   jmp 0x403268
# else:
#   jmp 0x40332c
#
# switch(number):
#   0: jmp do_thing_0
#   1: jmp do_thing_1
#   2: jmp do_thing_2
#   default: jmp do_default_thing
#
# A jump table is a contiguous section of memory that holds addresses of places to jump.
# In the above example, the jump table could look like:
# [0x1337] = address of do_thing_0
# [0x1337+0x8] = address of do_thing_1
# [0x1337+0x10] = address of do_thing_2
# [0x1337+0x18] = address of do_default_thing
#
# Using the jump table, we can greatly reduce the amount of cmps we use. Now all we need to check is if number is greater than 2. If it is, always do:
# jmp [0x1337+0x18]
# If it's not do jmp [0x1337 + number * 0x8]
