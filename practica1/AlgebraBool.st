!classDefinition: #BoolsTest category: #AlgebraBool!
DenotativeObject subclass: #BoolsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraBool'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoolsTest class' category: #AlgebraBool!
BoolsTest class
	instanceVariableNames: ''!

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:40:33'!
testFalsoOBoolEsBool
	Assert that: (Fals o: Verd) isEqualTo: Verd.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:42:41'!
testFalsoyBoolEsFalso
	Assert that: (Fals y: Verd) isEqualTo: Fals.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:04:26'!
testIFalsoSiVerdaderoNoEvaluaAccion
	| resultado |

	resultado := #NoEvalúa.
	
	Verdadero siVerdadero: [resultado := #Evalúa].

	Assert that: resultado isEqualTo: #Evalúa! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:49:06'!
testNoFalsoEsVerdadero
	Assert that: Fals isNotEqualTo: Verd.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:50:46'!
testNoVerdaderoEsFalso
	Assert that: Verd  isNotEqualTo: Fals.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:51:10'!
testVerdaderoOBoolEsVerdadero
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:06:03'!
testVerdaderoSiFalsoNoEvaluaAccion
	|res|
	res := 'Es Verdadero'.
	Verd siFalso: [res := 'Es Falso'].
	Assert that: res isEqualTo: 'Es Verdadero'.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:52:16'!
testVerdaderoSiVerdaderoEvaluaAccion
	|res|
	res := -1.
	Verd siVerdadero: [res := 2+2].
	Assert that: res isEqualTo: 4.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:52:38'!
testVerdaderoyBoolEsBool
	Assert that: (Verd y: Fals) isEqualTo: Fals.! !


!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:40:33'!
testFalsoOBoolEsBool
	Assert that: (Fals o: Verd) isEqualTo: Verd.! !

!BoolsTest class methodsFor: '-- all --' stamp: 'MC 3/25/2025 19:06:27'!
testFalsoSiFalsoEvaluaAccio
	|res|
	res := 'Es Verdadero'.
	Fals siFalso: [res := 'Es Falso'].
	Assert that: res isEqualTo: 'Es Falso'.! !

!BoolsTest class methodsFor: '-- all --' stamp: 'MC 3/25/2025 19:06:32'!
testFalsoSiFalsoEvaluaAccion
	| res |
	res := 'Es Verdadero'.
	Fals siFalso: [res := 'Es Falso'].
	Assert that: res isEqualTo: 'Es Falso'.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:42:41'!
testFalsoyBoolEsFalso
	Assert that: (Fals y: Verd) isEqualTo: Fals.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:04:26'!
testIFalsoSiVerdaderoNoEvaluaAccion
	| resultado |

	resultado := #NoEvalúa.
	
	Verdadero siVerdadero: [resultado := #Evalúa].

	Assert that: resultado isEqualTo: #Evalúa! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:49:06'!
testNoFalsoEsVerdadero
	Assert that: Fals isNotEqualTo: Verd.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:50:46'!
testNoVerdaderoEsFalso
	Assert that: Verd  isNotEqualTo: Fals.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:51:10'!
testVerdaderoOBoolEsVerdadero
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:06:03'!
testVerdaderoSiFalsoNoEvaluaAccion
	|res|
	res := 'Es Verdadero'.
	Verd siFalso: [res := 'Es Falso'].
	Assert that: res isEqualTo: 'Es Verdadero'.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:52:16'!
testVerdaderoSiVerdaderoEvaluaAccion
	|res|
	res := -1.
	Verd siVerdadero: [res := 2+2].
	Assert that: res isEqualTo: 4.! !

!BoolsTest class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 18:52:38'!
testVerdaderoyBoolEsBool
	Assert that: (Verd y: Fals) isEqualTo: Fals.! !


!classDefinition: #Fals category: #AlgebraBool!
DenotativeObject subclass: #Fals
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraBool'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fals class' category: #AlgebraBool!
Fals class
	instanceVariableNames: ''!

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:02:59'!
no
	^Verd! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:05'!
o: aBooleano 
	^ aBooleano! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:04:54'!
siFalso: aAccionARealizarUIgnorar
	 aAccionARealizarUIgnorar value! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:01:48'!
siVerdadero: aAccionARealizarUIgnorar

	! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:20'!
y: aBooleano

	^self! !


!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:02:59'!
no
	^Verd! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:05'!
o: aBooleano 
	^ aBooleano! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:04:54'!
siFalso: aAccionARealizarUIgnorar
	 aAccionARealizarUIgnorar value! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:01:48'!
siVerdadero: aAccionARealizarUIgnorar

	! !

!Fals class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:20'!
y: aBooleano

	^self! !


!classDefinition: #Verd category: #AlgebraBool!
DenotativeObject subclass: #Verd
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraBool'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verd class' category: #AlgebraBool!
Verd class
	instanceVariableNames: ''!

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:37'!
no
	^Fals! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:45'!
o: aBooleano 

	^self! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:05:40'!
siFalso: aAccionARealizarUIgnorar
	! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:50'!
siVerdadero: aAccionARealizarUIgnorar 

	 aAccionARealizarUIgnorar  value! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:04:05'!
y: aBooleano

	^aBooleano! !


!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:37'!
no
	^Fals! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:45'!
o: aBooleano 

	^self! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:05:40'!
siFalso: aAccionARealizarUIgnorar
	! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:03:50'!
siVerdadero: aAccionARealizarUIgnorar 

	 aAccionARealizarUIgnorar  value! !

!Verd class methodsFor: 'as yet unclassified' stamp: 'MC 3/25/2025 19:04:05'!
y: aBooleano

	^aBooleano! !
