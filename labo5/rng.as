/*******************************************************************************
	Ce sous-programme génère des nombres aléatoires en manipulant
	une chaîne de bits avec des opérations arithmétiques et logiques.

	Entrées:
		x0: Adresse de la valeur initiale du générateur (adresse 64 bits)
		x1: Constante multiplicative (entier 32 bits non-signé)
		X2: Constante additive (entier 32 bits non-signé)

	Sorties:
		x0: Valeur aléatoire générée (entier 32 bits non-signé)
		[x0]: Prochaine valeur initiale (entier 32 bits non-signé)


	Auteur.e.s:


*******************************************************************************/


.include "/root/SOURCES/ift209/tools/ift209.as"
.global Random


.section ".text"



Random:
		SAVE
		mov		x19, x0					// Sauvegarde l'adresse Memoire de x0
		mov		w20, w1					// Constante multiplicative (m)
		mov		w21, w2					// Constante additive (n)
		ldr		x23, [x19, #0]			// seed

		madd	x24, x23, x20, x21		// ( seed x m ) + n = (s1)
		madd	x25, x24, x20, x21		// ( seed x m ) + n = (s2)
		madd	x26, x25, x20, x21		// ( seed x m ) + n = (s3)

		lsl		x26, x26, #16			// s3 <<< 16
		str		x26, [x19, #0]			// Sauvegarde s3 dans le seed[0]
		lsl		x25, x25, #16			// s2 <<< 16
		str		x25, [x19, #10]			// Sauvegarde s2 dans le seed[1]
		lsl		x24, x24, #16			// s1 <<< 16
		str		x25, [x19, #20]			// Sauvegarde s1 dans le seed[2]



		RESTORE
		ret
