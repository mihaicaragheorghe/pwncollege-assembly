.intel_syntax noprefix
.global _start
_start:
mov rax, [rdi] 
mov rdi, [rax]
mov rdi, [rdi]
mov rax, 60
syscall

#         Address │ Contents
#       +────────────────────+
# ┌────▸│ 133700  │ 123400   │───┐
# │     +────────────────────+   │
# │ ┌──▸│ 123400  │ 100000   │─┐ │
# │ │   +────────────────────+ │ │
# │ │ ┌▸│ 100000  │ 42       │ │ │
# │ │ │ +────────────────────+ │ │
# │ │ └────────────────────────┘ │
# │ └────────────────────────────┘
# └──────────────────────────────┐
#                                │
#        Register │ Contents     │
#       +────────────────────+   │
#       │ rdi     │ 133700   │───┘
#       +────────────────────+
#
# triple dereferencing from rdi to the address 100000 which holds the value 42.