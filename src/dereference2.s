.intel_syntax noprefix
.global _start
_start:
mov rax,[rax] 
mov rdi, [rax]
mov rax, 60
syscall

#       Address │ Contents
#     +────────────────────+
# ┌──▸│ 133700  │ 123400   │─┐
# │   +────────────────────+ │
# │ ┌▸│ 123400  │ 42       │ │
# │ │ +────────────────────+ │
# │ └────────────────────────┘
# └──────────────────────────┐
#                            │
#      Register │ Contents   │
#     +────────────────────+ │
#     │ rax     │ 133700   │─┘
#     +────────────────────+
#
# we dereference rax which points to address 133700, which points to address 13400 which cointains the value 42.
