.intel_syntax noprefix
.global _start
_start:
pop rax         # Pop top value from stack into rax
sub rax, rdi    # Subtract rdi from it
push rax        # Push it back
