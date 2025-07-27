#Programa que inicializa vetor C como a soma dos elementos correspondentes em A e B
#Ao final, apresenta vetor C
.data
	str1: .string "\n Vetor["
	str2: .string "]  = "
	n: .word 10 #numero de elementos no vetor
	A: .word 0, 1, 2, 3, 4, 5, 6,7 ,8, 9
	B: .word 0, 100, 200, 300, 400, 500, 600, 700, 800, 900
	C: .word -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,

# t0 = i do for
# t1 = n° elementos do vetor
# s0 = endeço do primeiro elemento de C
# s1 = enderelo do primeiro elemento de A
# s2 = enderelo do primeiro elemento de B
# t2 = valor do i atual*4 (usado para acessar elementos do vetor --espassados de 4 em 4 bytes)
# a0 -> s9 = posicao atual vetor C
# a1 = posicao atual vetor A
# a2 = posicao atual vetor B
# t5 = valor da soma de A[i] e B[i]


.text
	li t0, 0
	lw, t1, n
	la, s0, C
	la, s1, A
	la, s2, B
	

for:
	beq t0, t1, done
	slli t2, t0 ,2 # multipico i por 4
	
	# mudo a posicao atual dos indices dos vetores
	add s9, s0, t2
	add a1, s1, t2
	add a2, s2, t2
	
	#load nos valores dos vetores
	lw s3, 0(a1)
	lw s4, 0(a2)
	
	
	add t5, s4, s3 # faço a soma
	
	sw t5, 0(s9) # guardo a soma no endereço do vetor
	
	addi t0, t0, 1 # i++
	j for # volta para for
done:


	jal print

	li, a7, 10
	ecall


	print:
		li t0, 0
		for2:
			beq t0, t1, done2 # sai do for qnd percorrer 10 itens
			
			la a0, str1 #" Vetor[
			li a7, 4
			ecall
			
			mv a0, t0 #posicaovetor
			li a7, 1
			ecall
			
			
			la a0, str2 #] = 
			li a7, 4
			ecall
			
			slli t2, t0 ,2 # multipico i por 4
			add s9, s0, t2 # nova posicao atual de C
			lw a0, 0(s9)  # carrego o valor atual do vetor em a0
			li a7, 1
			ecall
			
			
			addi, t0, t0, 1 # i++
			j for2
		
	done2:
		ret # retorna para a linha 55
		

	