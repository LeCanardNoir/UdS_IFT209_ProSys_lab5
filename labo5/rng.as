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
		ldr		w22, [x19]				// seed

		mov		x28, #3					//x28 est le nombre d'itérations restantes
		mov		x25, xzr				//x25 est le résultat
		cmp		x28, #1					//3-2 devrait set le carry out bit

Random_Loop:
		cbz		x28, Random_LoopEnd
		madd	x22, x22, x20, x21		// seed = (seed * m) + n
		uxtw	x22, w22				// seed est un 32 bits
		lsr		x27, x22, #16			// met dans x27 les bits du seed en commençant au bit 16

		mov		x15, #1
		adc		x16, xzr, #10			//À la première itération, x16 vaut 11. Aux autres itérations, x16 vaut 10
		lsl		x15, x15, x16
		sub		x15, x15, #1			//x15 contient les un nombre avec les 10 (ou 11) bits moins significatifs à 1

		lsl		x25, x25, #10			//On tasse résultat à gauche de 10 bits
		and		x27, x27, x15			//On garde dans x27 les 10 (ou 11) bits les moins significatifs
		orr		x25, x25, x27			//Et on les insère dans le résultat

		subs	x28, x28, #1			//À toutes les itérations, sauf la première, on reset le carry out bit

		b.al	Random_Loop


Random_LoopEnd:



		RESTORE
		ret
