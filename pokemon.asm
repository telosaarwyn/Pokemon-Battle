.globl main

.data
# Pokemon types data (First 10 Pokemon for example ONLY)
# Format: Type1, Type2 (255 if no second type, 0xFF)
#  1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18
# Nor, Fig, Fly, Poi, Gro, Roc, Bug, Gho, Ste, Fir, Wat, Gra, Ele, Psy, Ice, Dra, Dar, Fai
#each .byte contains 10 pokemons
pokemon_types: 
    .byte 0, 0 #garbage so that it will start on 1
	#    1    |    2    |    3    |    4    |    5    |    6    |    7    |    8    |    9    |    10
    .byte 12,   4,  12,   4,  12,   4,  10, 255,  10, 255,  10,   3,  11, 255,  11, 255,  11, 255,   7, 255
    .byte  7, 255,   7,   3,   7,   4,   7,   4,   7,   4,   1,   3,   1,   3,   1,   3,   1, 255,   1, 255
    .byte  1,   3,   1,   3,   4, 255,   4, 255,  13, 255,  13, 255,   5, 255,   5, 255,   4, 255,   4, 255
    .byte  2,   5,   4, 255,   4, 255,   4,   5,   1, 255,   1, 255,  10, 255,  10, 255,   1, 255,   1, 255
    .byte  4,   3,   4,   3,  12,   4,  12,   4,  12,   4,   7,  12,   7,  12,   7,   4,   7,   4,   5, 255
    .byte  5, 255,   1, 255,   1, 255,  11, 255,  11, 255,   2, 255,   2, 255,  10, 255,  10, 255,  11, 255
    .byte 11, 255,  11,   2,  14, 255,  14, 255,  14, 255,   2, 255,   2, 255,   2, 255,  12,   4,  12,   4
    .byte 12,   4,  11,   4,  11,   4,   6,   5,   6,   5,   6,   5,  10, 255,  10, 255,  11,  14,  11,  14
    .byte 13, 255,  13, 255,   1,   3,   1,   3,   1,   3,  11, 255,  11,  15,   4, 255,   4, 255,  11, 255
    .byte 11,  15,   8,   4,   8,   4,   8,   4,   6,   5,  14, 255,  14, 255,  11, 255,  11, 255,  13, 255

# Type effectiveness matrix
# 18x18 matrix flattened into a 1D array
# Format: Attack type (row) x Defense type (column)
effectiveness: 
	#   Nor,  Fig,  Fly,  Poi,  Gro,  Roc,  Bug,  Gho,  Ste,  Fir,  Wat,  Gra,  Ele,  Psy,  Ice,  Dra,  Dar,  Fai
    .float  1.0,  1.0,  1.0,  1.0,  1.0,  0.5,  1.0,  0.0,  0.5,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0	#Nor 0
    .float  2.0,  1.0,  0.5,  0.5,  1.0,  2.0,  0.5,  0.0,  2.0,  1.0,  1.0,  1.0,  1.0,  0.5,  2.0,  1.0,  2.0,  0.5	#Fig 18
    .float  1.0,  2.0,  1.0,  1.0,  1.0,  0.5,  2.0,  1.0,  0.5,  1.0,  1.0,  2.0,  0.5,  1.0,  1.0,  1.0,  1.0,  1.0	#Fly 36
    .float  1.0,  1.0,  1.0,  0.5,  0.5,  0.5,  1.0,  0.5,  0.0,  1.0,  1.0,  2.0,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0	#Poi 0.54
    .float  1.0,  1.0,  0.0,  2.0,  1.0,  2.0,  0.5,  1.0,  2.0,  2.0,  1.0,  0.5,  2.0,  1.0,  1.0,  1.0,  1.0,  1.0	#Gro 72
    .float  1.0,  0.5,  2.0,  1.0,  0.5,  1.0,  2.0,  1.0,  0.5,  2.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  1.0	#Roc 90
    .float  1.0,  0.5,  0.5,  0.5,  1.0,  1.0,  1.0,  0.5,  0.5,  0.5,  1.0,  2.0,  1.0,  2.0,  1.0,  2.0,  1.0,  0.5	#Bug 1.08
    .float  0.0,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  0.5,  1.0	#Gho 126
    .float  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  0.5,  0.5,  0.5,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  2.0	#Ste 144
    .float  1.0,  1.0,  1.0,  1.0,  1.0,  0.5,  2.0,  1.0,  2.0,  0.5,  0.5,  2.0,  1.0,  1.0,  2.0,  0.5,  1.0,  1.0	#Fir 162
    .float  1.0,  1.0,  1.0,  1.0,  2.0,  2.0,  1.0,  1.0,  1.0,  2.0,  0.5,  0.5,  1.0,  1.0,  1.0,  0.5,  1.0,  1.0	#Wat 180
    .float  1.0,  1.0,  0.5,  0.5,  2.0,  2.0,  0.5,  1.0,  0.5,  0.5,  2.0,  0.5,  1.0,  1.0,  1.0,  0.5,  1.0,  1.0	#Gra 198
    .float  1.0,  1.0,  2.0,  1.0,  0.0,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  0.5,  0.5,  1.0,  1.0,  0.5,  1.0,  1.0	#Ele
    .float  1.0,  2.0,  1.0,  2.0,  1.0,  1.0,  1.0,  1.0,  0.5,  1.0,  1.0,  1.0,  1.0,  0.5,  1.0,  1.0,  0.0,  1.0	#Psy
    .float  1.0,  1.0,  2.0,  1.0,  2.0,  1.0,  1.0,  1.0,  0.5,  0.5,  0.5,  2.0,  1.0,  1.0,  0.5,  2.0,  1.0,  1.0	#Ice
    .float  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  0.5,  1.0,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  0.0	#Dra
    .float  1.0,  0.5,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  1.0,  1.0,  0.5,  0.5	#Dar
    .float  1.0,  2.0,  1.0,  0.5,  1.0,  1.0,  1.0,  1.0,  0.5,  0.5,  1.0,  1.0,  1.0,  1.0,  1.0,  2.0,  2.0,  1.0	#Fai
    
    
newline: .asciz "\n"
prompt_pokemon1: .asciz "Enter the number of the first Pokemon: "
prompt_pokemon2: .asciz "Enter the number of the second Pokemon: "
result_tie: .asciz "It's a tie!\nReturning "
result_pokemon1: .asciz "First Pokemon wins!\nPokemon #"
result_pokemon2: .asciz "Second Pokemon wins!\nPokemon #"

.text
main:
    li a7, 4
    la a0, prompt_pokemon1
    ecall

    # Read first Pokemon number
    li a7, 5
    ecall
    mv t1, a0   # Store the first Pokemon number in t1
    mv s0, a0	# for output

    # Prompt for second Pokemon
    li a7, 4
    la a0, prompt_pokemon2
    ecall

    # Read second Pokemon number
    li a7, 5
    ecall
    mv t2, a0   # Store the second Pokemon number in t2
    mv s1, a0	 # for output

    # Call the compare_pokemon function
    mv a0, t1
    mv a1, t2
    jal ra, compare_pokemon

    # Exit the program
    li a7, 10
    ecall

compare_pokemon:
    # Load Pokemon A types
    slli t0, a0, 1  # t0 = pokemon_number * 2
    la t1, pokemon_types
    add t1, t1, t0  # t1 = address of pokemon_types[pokemon_number]
    lb t2, 0(t1)    # t2 = Type1 of Pokemon A
    lb t3, 1(t1)    # t3 = Type2 of Pokemon A
    andi t3, t3, 0xFF 	#in case of 255, only last 8 bits should be saved

    # Load Pokemon B types
    slli t0, a1, 1
    la t1, pokemon_types
    add t1, t1, t0
    lb t4, 0(t1)    # t4 = Type1 of Pokemon B
    lb t5, 1(t1)    # t5 = Type2 of Pokemon B
    andi t5, t5, 0xFF 	#in case of 255, only last 8 bits should be saved

    # Calculate effectiveness for Pokemon A against Pokemon B
    mv a2, t2
    mv a3, t3
    mv a4, t4
    mv a5, t5
    jal ra, calculate_effectiveness
    fmv.s fs4, fs1  # Save score for Pokemon A

    # Calculate effectiveness for Pokemon B against Pokemon A
    mv a2, t4
    mv a3, t5
    mv a4, t2
    mv a5, t3
    jal ra, calculate_effectiveness

    # Compare scores
    flt.s a0, fs4, fs1 
    bnez a0, pokemon_b_wins
    
    feq.s a0, fs4, fs1
    bnez a0, tie

pokemon_a_wins:
    li a7, 56
    la a0, result_pokemon1
    mv a1, s0
    ecall
    j end

pokemon_b_wins:
    li a7, 56
    la a0, result_pokemon2
    mv a1, s1
    ecall
    j end

tie:
    addi s0, x0, -1
    li a7, 56
    la a0, result_tie
    mv a1, s0
    ecall

end:
    li a7, 10
    ecall

calculate_effectiveness:
    # Calculate effectiveness for first type
    la t6, effectiveness
    li t0, 18         	# constant 18
    addi a2, a2, -1	# a2 = a2 - 1 since count starts in 0
    addi a4, a4, -1 	# a4 = a4 - 1
    mul t1, a2, t0     # t1 = a2 * 18
    add t1, t1, a4     # t1 = t1 + a4
    slli t1, t1, 2	# multiply offset by 4 since float is 32 bytes
    add t1, t6, t1     # t1 = t6 + t1
    flw fs0, 0(t1)     # fs0 = effectiveness value
    fmv.s fs1, fs0        # save in ft1

    # Calculate effectiveness for second type if exists
    li t0, 255
    beq a5, t0, skip_second_type

    li t0, 18         		# constant 18
    addi a5, a5, -1 		# a5 = a5 - 1
    mul t1, a2, t0    		# t1 = a2 * 18
    add t1, t1, a5     	# t1 = t1 + a5
    slli t1, t1, 2		# multiply offset by 4 since float is 32 bytes
    add t1, t6, t1     	# t1 = t6 + t1
    flw fs0, 0(t1)      	# fs0 = effectiveness value
    fmul.s fs1, fs1, fs0  	# fs1 = fs1 * fs0

skip_second_type:
    # Calculate effectiveness for defending Pokemon second type if exists
    li t0, 255
    li a1, 0
    fcvt.s.w fs2, a1	#set fs2 to zero incase no second type
    beq a3, t0, done
    
    li t0, 18          # constant 18
    addi a3, a3, -1	# a3 = a3 - 1 since count starts in 0
    mul t1, a3, t0     # t1 = a3 * 18
    add t1, t1, a4     # t1 = t1 + a4
    slli t1, t1, 2	# multiply offset by 4 since float is 32 bytes
    add t1, t6, t1     # t1 = t6 + t1
    flw fs0, 0(t1)     # t2 = effectiveness value
    fmv.s fs2, fs0        # save in fs2

    li t0, 255
    beq a5, t0, done

    li t0, 18          	# constant 18
    mul t1, a3, t0     	# t1 = a3 * 18
    add t1, t1, a5    		# t1 = t1 + a5
    slli t1, t1, 2	# multiply offset by 4 since float is 32 bytes
    add t1, t6, t1     	# t1 = t6 + t1
    flw fs0, 0(t1)       	# fs0 = effectiveness value
    fmul.s fs2, fs2, fs0     	# fs2 = fs2 * fs0

done:
    li a1, 0
    fcvt.s.w ft0, a1		#set ft0 to zero
    feq.s a1, fs2, ft0
    bne a1, x0, continue
    fadd.s fs1, fs1, fs2	#a0 = a0 + a1
    li a1, 2
    fcvt.s.w fs2, a1
    
    fdiv.s fs1, fs1, fs2	#Division: set fs1 to the result of fs1/fs2
    div a0, a0, a1      
    
continue:
    ret
