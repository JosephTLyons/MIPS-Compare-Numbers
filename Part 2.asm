################# Data segment #####################
.data

################# Code segment #####################
.text
.globl main

main:
	 addi $a0, $a0, 30
	 addi $a1, $a1, 20
         jal  Compare
         j    Exit
      
Compare: addi $sp, $sp, -4      # Adjust sp for room to back up main return address
         sw   $ra, 0($sp)       # Store return address
         
         jal  Sub               # Jump to Sub
         slt  $t1,   $v0, $zero # $v0 has A - B value stored in it from Sub
         bne  $zero, $t1, Skip  # Skip if A - B = negative number (as in A < B)
         addi $v0,   $zero, 1   # Else, return 1 because A >= B
         lw   $ra,   0($sp)     # Recover main returning address
         addi $sp,   $sp, 4     # Adjust stack back
         jr   $ra               # Go to main
         
Skip:    addi $v0, $zero, 0     # return 0, because A < B
         lw   $ra, 0($sp)       # Recover main returning address
         addi $sp, $sp, 4       # Adjust stack back
	 jr   $ra               # Go to main

Sub:     sub $v0, $a0, $a1      # Subtrack A - B
         jr  $ra                # Return to Compare

Exit: