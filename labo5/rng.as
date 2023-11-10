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
		mov		w20, w1					// Constante multiplicative
		mov		w21, w2					// Constante additive 

		

		RESTORE
		ret
