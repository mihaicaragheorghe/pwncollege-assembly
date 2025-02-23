# Each register in x86_64 is 64 bits in size,
# The lower 32 bits of rax can be accessed using eax, the lower 16 bits using ax, and the lower 8 bits using al.
#
# MSB                                    LSB
# +----------------------------------------+
# |                   rax                  |
# +--------------------+-------------------+
#                      |        eax        |
#                      +---------+---------+
#                                |   ax    |
#                                +----+----+
#                                | ah | al |
#                                +----+----+

.intel_syntax noprefix
.global _start
_start:
mov ah, 0x42
