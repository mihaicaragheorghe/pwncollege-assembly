.intel_syntax noprefix
.global _start
_start:
mov rdi,[rdi+1] 
mov rax, 60
syscall

#     Address │ Contents
#   +────────────────────+
#   │ 133700  │ 50       │
# ┌▸│ 133701  │ 42       │
# │ │ 133702  │ 99       │
# │ │ 133703  │ 14       │
# │ +────────────────────+
# │
# └────────────────────────┐
#                          │
#    Register │ Contents   │
#   +────────────────────+ │
#   │ rdi     │ 133700   │─┘
#   +────────────────────+
#
# this will give us the value stored at 133701, which is 42.