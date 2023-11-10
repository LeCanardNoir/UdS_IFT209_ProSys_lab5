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
		ldr		w23, [x19, #0]			// seed
		mov		w10, #0					// resultat

		madd	w24, w23, w20, w21		// ( seed x m ) + n = (s1)
		madd	w25, w24, w20, w21		// ( seed x m ) + n = (s2)
		madd	w26, w25, w20, w21		// ( seed x m ) + n = (s3)

		str		w26, [x19]

		lsr		w24, w24, #16			// s1 >>> 16
		and		w24, w24, 0b11111111111	// garder seulement les 11 derniers bits	(s1)
		lsl		w24, w24, #20
		orr		w10, w10, w24

		lsr		w25, w25, #16			// s2 >>> 16
		and		w25, w25, 0b1111111111	// garder seulement les 10 derniers bits	(s2)
		lsl		w25, w25, #10
		orr		w10, w10, w25

		lsr		w26, w26, #16			// s3 >>> 16
		and		w26, w26, 0b1111111111	// garder seulement les 10 derniers bits	(s3)		
		orr		w10, w10, w26

		mov		w0, w10


		RESTORE
		ret