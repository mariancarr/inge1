!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'mc 4/8/2025 15:23:29'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'mc 4/8/2025 15:24:05'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'mc 4/8/2025 15:24:38'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'mc 4/8/2025 15:24:47'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'mc 4/8/2025 15:20:44'!
setUp

	zero := Entero with: 0.
	one := Entero  with: 1.
	two := Entero  with: 2.
	three:= Entero with: 3.
	four := Entero  with: 4.
	five := Entero  with: 5.
	eight := Entero with: 8.
	negativeOne := Entero  with: -1.
	negativeTwo := Entero  with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:34:11'!
+ anAdder 
	
	self subclassResponsibility. 
	
	"* aMultiplier 

	^self subclassResponsibility. "
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:34:15'!
// aDivisor 
	
	self subclassResponsibility. 
		
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:13:09'!
greatestCommonDivisorWith: anEntero 
	
	^self subclassResponsibility. 
		
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:26:55'!
negated
	
	self subclassResponsibility. ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:13:29'!
printOn: aStream
	
	^self subclassResponsibility. ! !


!Numero methodsFor: 'testing' stamp: 'mc 4/8/2025 14:45:00'!
isNegative
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'mc 4/8/2025 14:45:03'!
isOne

	^self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'mc 4/8/2025 14:45:07'!
isZero

	^self subclassResponsibility ! !


!Numero methodsFor: 'initialization' stamp: 'mc 4/8/2025 14:43:33'!
initializeWith: aValue
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'initialization' stamp: 'mc 4/8/2025 14:43:49'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	
	
	^self subclassResponsibility ! !


!Numero methodsFor: 'accessing' stamp: 'mc 4/8/2025 15:11:49'!
denominator

	^self subclassResponsibility ! !

!Numero methodsFor: 'accessing' stamp: 'mc 4/8/2025 15:12:10'!
integerValue

	^self subclassResponsibility ! !

!Numero methodsFor: 'accessing' stamp: 'mc 4/8/2025 15:13:26'!
numerator
	^self subclassResponsibility ! !


!Numero methodsFor: 'comparing' stamp: 'mc 4/8/2025 15:13:05'!
= anObject

	^self subclassResponsibility. ! !

!Numero methodsFor: 'comparing' stamp: 'mc 4/8/2025 15:11:56'!
hash

	^self subclassResponsibility. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !



!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'accessing' stamp: 'mc 4/8/2025 14:19:50'!
integerValue
	
	^value! !


!Entero methodsFor: 'comparing' stamp: 'mc 4/8/2025 14:51:35'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue].
! !

!Entero methodsFor: 'comparing' stamp: 'mc 4/8/2025 14:23:23'!
hash
	^value hash.! !


!Entero methodsFor: 'testing' stamp: 'mc 4/8/2025 14:39:34'!
isNegative
		^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'mc 4/8/2025 14:39:51'!
isOne
	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'mc 4/8/2025 14:40:25'!
isZero

	^value = 0.! !


!Entero methodsFor: 'initialization' stamp: 'mc 4/8/2025 14:06:14'!
initializeWith: aValueEntero
	value := aValueEntero.! !


!Entero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 14:49:53'!
* aMultiplier 

		^self class with: value * aMultiplier integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 14:57:16'!
+ anAdder 

	^self class with: value + anAdder integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:01:08'!
// aDivisor 

	^self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:02:20'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:03:16'!
negated
	
	^self * (self class with: -1).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:04:21'!
printOn: aStream

	 aStream print: value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'mc 4/8/2025 15:14:02'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'initialization' stamp: 'mc 4/8/2025 14:44:13'!
initializeWith: aNumerator over: aDenominator

	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	numerator := aNumerator.
	denominator := aDenominator.! !


!Fraccion methodsFor: 'accessing' stamp: 'mc 4/8/2025 14:18:55'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'mc 4/8/2025 14:19:19'!
numerator

	^numerator! !


!Fraccion methodsFor: 'testing' stamp: 'mc 4/8/2025 14:40:54'!
isNegative

	^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'mc 4/8/2025 14:41:33'!
isOne

	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'mc 4/8/2025 14:42:00'!
isZero
	
	^false.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 14:55:55'!
* aMultiplier 

	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 14:58:38'!
+ anAdder 
		 | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:10:06'!
// aDivisor 
	
	self error: 'Tipo de número no soportado'.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:10:46'!
greatestCommonDivisorWith: anEntero 
		
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:31:34'!
negated

	^self class with: numerator * (numerator class with: -1) over: denominator.
	
	"self class with: numerator * (Entero with: -1) over: denominator. Este tmb funciona, al principio no funcion'o porque estaba poniendo Entero class with: y no tiene sentido pedirle la clase a Entero"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 4/8/2025 15:04:48'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator .! !


!Fraccion methodsFor: 'comparing' stamp: 'mc 4/8/2025 14:52:40'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator)].! !

!Fraccion methodsFor: 'comparing' stamp: 'mc 4/8/2025 14:24:06'!
hash
	^(numerator hash / denominator hash) hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'mc 4/8/2025 15:14:36'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
