.intel_syntax noprefix
.global _start
_start:
mov rax, 133700
mov rdi, [rax]
mov rax, 60
syscall

#     Address │ Contents
#   +────────────────────+
# ┌▸│ 133700  │ 42       │
# │ +────────────────────+
# │
# └────────────────────────┐
#                          │
#    Register │ Contents   │
#   +────────────────────+ │
#   │ rax     │ 133700   │─┘
#   +────────────────────+
#   
# rax now holds a value that corresponds with the address of the data that want to load.
# then we load into rdi.
