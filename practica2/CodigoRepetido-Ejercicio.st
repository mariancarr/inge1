!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'setUp' stamp: 'MC 4/1/2025 20:40:38'!
setter
	customerBooks := CustomerBook new.
	
	! !


!CustomerBookTest methodsFor: 'error' stamp: 'MC 4/1/2025 21:01:03'!
error: aCausaError con: aTipoError hace: aBlockRespuestaError
	[ aCausaError.
	self fail ]
		on: aTipoError
		do: aBlockRespuestaError.! !

!CustomerBookTest methodsFor: 'error' stamp: 'MC 4/1/2025 21:08:32'!
errorNombreVacio
	^[ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBooks isEmpty ]! !

!CustomerBookTest methodsFor: 'error' stamp: 'MC 4/1/2025 20:55:21'!
errorRemoverInvalidCustomer
	^[ :anError | 
			self assert: customerBooks numberOfCustomers = 1.
			self assert: (customerBooks includesCustomerNamed: 'John Lennon')].
	! !

!CustomerBookTest methodsFor: 'error' stamp: 'MC 4/1/2025 21:18:28'!
errorSuspenderCustomerInvalido
		^[ :anError | 
			self assert: customerBooks numberOfCustomers = 1.
			self assert: (customerBooks includesCustomerNamed: 'John Lennon') ]! !

!CustomerBookTest methodsFor: 'error' stamp: 'MC 4/1/2025 21:22:01'!
errorSuspendoDosVecesAlMismo
	[ :anError | 
		self assert: customerBooks numberOfCustomers = 1. 
		self assert: (customerBooks includesCustomerNamed: 'Jhon Lennon') ]! !

!CustomerBookTest methodsFor: 'error' stamp: 'MC 4/1/2025 21:13:03'!
errores: aCausaError con: aTipoError hace: aBlockRespuestaError
		aCausaError
		on: aTipoError
		do: aBlockRespuestaError.! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MC 4/1/2025 20:40:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self setter.
	self shouldNot: [customerBooks addCustomerNamed:'Jhon Lennon'] takeMoreThan: 50*millisecond.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MC 4/1/2025 20:41:04'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	|customer|
	customer :='Paul McCartney'.
	self setter.
	customerBooks addCustomerNamed: customer.
	self shouldNot: [customerBooks removeCustomerNamed: customer] takeMoreThan: 100* millisecond. 
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MC 4/1/2025 21:12:37'!
test03CanNotAddACustomerWithEmptyName 
	self setter.
	self errores: [customerBooks addCustomerNamed: ''. self fail]  con: Error  hace: self errorNombreVacio. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MC 4/1/2025 21:14:36'!
test04CanNotRemoveAnInvalidCustomer
	
	self setter.
	customerBooks addCustomerNamed: 'John Lennon'.
	self errores:[customerBooks removeCustomerNamed: 'Paul McCartney'. self fail] con: NotFound  hace: self   errorRemoverInvalidCustomer 
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MC 4/1/2025 21:19:22'!
test07CanNotSuspendAnInvalidCustomer		
	self setter.
	customerBooks addCustomerNamed: 'John Lennon'.
	self errores:[customerBooks suspendCustomerNamed: 'George Harrison'. self fail] con: CantSuspend hace: self errorSuspenderCustomerInvalido.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MC 4/1/2025 21:22:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	|johnLennon |
			
	customerBooks := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBooks addCustomerNamed: johnLennon.
	customerBooks suspendCustomerNamed: johnLennon.
	
	self errores: [ customerBooks suspendCustomerNamed: johnLennon. self fail ] con: CantSuspend hace: self errorSuspendoDosVecesAlMismo.
! !


!CustomerBookTest methodsFor: 'temporizador' stamp: 'MC 4/1/2025 17:02:42'!
timeRunning: aBlockATemporizar
	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockATemporizar value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning.! !


!CustomerBookTest methodsFor: 'assert' stamp: 'MC 4/1/2025 17:10:27'!
shouldNot: aBlockATemporizar  takeMoreThan: aTiempo
	|tiempoCorriendo|
	tiempoCorriendo := self timeRunning: aBlockATemporizar .
	self assert: tiempoCorriendo < aTiempo.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
