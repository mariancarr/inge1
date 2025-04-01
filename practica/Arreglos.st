'From Cuis6.3 [latest update: #6350] on 25 March 2025 at 3:01:34 pm'!
!classDefinition: #Arreglos category: #practica1!
Object subclass: #Arreglos
	instanceVariableNames: 'arreglo index impares iesimoElemento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'practica1'!

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:31:48'!
agregarAImpares
	impares add: iesimoElemento 
	! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:38:17'!
encontrarImparesDeArreglo
	self iniciarCalculo.
	[self indexDentroDeRangoArreglo] whileTrue:[
		self iesimoElementoArreglo.
		(self esOdd) ifTrue: [self agregarAImpares].
		self siguienteIndex.
		].
	^impares.! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:22:50'!
esOdd
	^ (iesimoElemento \\ 2) = 1.! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:31:26'!
iesimoElementoArreglo

	iesimoElemento := arreglo at: index.! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:24:51'!
indexDentroDeRangoArreglo
	^ index <= arreglo size.! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:08:13'!
iniciarArreglo: aArreglo
	arreglo := aArreglo.! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:22:10'!
iniciarCalculo

	impares := OrderedCollection new.
	index := 1! !

!Arreglos methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:31:07'!
siguienteIndex
	index := index +1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arreglos class' category: #practica1!
Arreglos class
	instanceVariableNames: ''!

!Arreglos class methodsFor: 'as yet unclassified' stamp: 'MC 2/28/2025 15:27:46'!
initialize: aArreglo
	^(self new) iniciarArreglo: aArreglo.! !
