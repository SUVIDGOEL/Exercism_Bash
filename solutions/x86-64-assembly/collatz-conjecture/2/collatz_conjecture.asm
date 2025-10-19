section .data
    format_in: db "%d", 0

section .bss
    num: resb 32 ;reserve 64 bytes 
    str_buf: resb 20

section .text
global steps
steps:
    ; Provide your implementation here
    mov rax, 0
    mov rdi, 0
    lea rsi, [rel num]
    mov rdx, 32
    syscall
    ;call scanf wrt ..plt

    lea rsi, [rel num]
    xor rax, rax
    xor rbx, rbx

.int_loop:
    movzx rbx, byte [rsi]
    cmp bl, 10
    je .con_int
    sub bl, "0"
    imul rax, 10
    add rax, rbx
    inc rsi
    jmp .int_loop

    
.con_int:
    mov r10, rax
    and r10, 0x1
    mov rbx, 0
    cmp r10, 0
    jnz .odd

.even:
    xor rdx, rdx
    mov rcx, 2
    div rcx
    inc rbx
    mov r10, rax
    and r10, 0x1
    cmp r10, 0
    jz .even

.odd:
    cmp rax, 1
    jz .con_str
    mov rcx, 3
    mul ecx
    inc rax
    inc rbx
    mov r10, rax
    and r10, 0x1
    cmp r10, 0
    jz .even
    jmp .odd

.con_str:
    mov rax, rbx
    mov rbx, 10
    xor rcx, rcx
    lea rdi, [rel str_buf]

.str_loop:
    xor rdx, rdx
    div rbx

    add rdx, "0"
    push rdx
    inc rcx

    test rax, rax
    jnz .str_loop
    mov r9, rcx

.pop_loop:
    pop rax
    mov [rdi], al
    inc rdi
    dec rcx
    cmp rcx, 0
    jnz .pop_loop

.write_str:
    mov byte [rdi], 0
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel str_buf]
    mov rdx, r9
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
    

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
