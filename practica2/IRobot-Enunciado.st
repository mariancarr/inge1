!classDefinition: #ProductTest category: #'IRobot-Enunciado'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:46'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ Product with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:51'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ Product with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #Tests category: #'IRobot-Enunciado'!
TestCase subclass: #Tests
	instanceVariableNames: 'trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Tests methodsFor: 'assert' stamp: 'mc 4/11/2025 12:15:22'!
shouldRaiseError: aBlockToValue withMessage: aTextMessageError

	self 
		should: [ 
			aBlockToValue value
		]
		raise: Error
		withMessageText: aTextMessageError.! !


!Tests methodsFor: 'setUp' stamp: 'mc 4/11/2025 13:00:51'!
setterWithTrailerWithWeight: aWeight andHeight: aHeight
	
	trailer := Trailer with: aWeight and: aHeight ! !


!classDefinition: #CashierTest category: #'IRobot-Enunciado'!
Tests subclass: #CashierTest
	instanceVariableNames: 'robot cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'mc 4/11/2025 13:01:10'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot
	
	self setterWithTrailerWithWeight: 20  andHeight: 100.

	self
		shouldRaiseError: [ 
			cashier receiveOrder: robot
		] 
		withMessage: Cashier trailerIsEmptyErrorDescription.
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'mc 4/11/2025 13:00:37'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	self setterWithTrailerWithWeight: 20 andHeight: 100.

	self
		shouldRaiseError: [ 
			robot withMechanicalFailure.
			cashier receiveOrder: robot
		] 
		withMessage: Cashier trailerIsEmptyErrorDescription.
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'mc 4/11/2025 13:01:20'!
test03ShouldNotAcceptSensorsFailureRobot

	self setterWithTrailerWithWeight: 20 andHeight: 100.

	self
		shouldRaiseError: [ 
			robot withSensorsFailure.
			cashier receiveOrder: robot
		]
		withMessage: Cashier robotSensorsFailureErrorDescription.
		
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'mc 4/11/2025 13:01:31'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	
	self setterWithTrailerWithWeight: 20 andHeight: 100. 

	self
		shouldRaiseError: [ 
			robot take: (ProductA with: 1  and: 1).
			robot withMechanicalFailure.
			
			cashier receiveOrder: robot.
			
			robot take: (ProductA with: 1 and: 1) 
		]  
		withMessage: Robot outOfOrderErrorDescription.
		

! !


!CashierTest methodsFor: 'setUp' stamp: 'mc 4/11/2025 13:03:19'!
setterWithTrailerWithWeight: aWeight andHeight: aHeight
	super setterWithTrailerWithWeight: aWeight andHeight: aHeight.
	robot := Robot with: trailer.
	cashier := Cashier new! !



!classDefinition: #RobotTest category: #'IRobot-Enunciado'!
Tests subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 18:26:53'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 18:48:41'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: #'IRobot-Enunciado'!
Tests subclass: #TrailerTest
	instanceVariableNames: 'halfExceededHeightCapacity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/10/2025 20:39:15'!
test01CanNotCreateTrailerWithCeroOrLessMaxWeight

	self
		shouldRaiseError: [ 
			Trailer with: 0  and: 100 
		] 
		withMessage: Trailer invalidWeightCapacityErrorDescription.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/10/2025 20:28:02'!
test02CanNotCreateTrailerWithCeroOrLessMaxHeight

	self 
		shouldRaiseError: [ 
			Trailer with: 1  and: 0 
		] 
		withMessage: Trailer invalidHeightCapacityErrorDescription. 
		! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/10/2025 20:28:32'!
test03CanNotCreateTrailerWithNoIntegerMaxWeight

	self 
		shouldRaiseError:[ 
			Trailer with: 1.5  and: 100 
		]  
		withMessage: Trailer weightCapacityMustBeIntegerErrorDescription. 
		! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/10/2025 20:29:16'!
test04CanNotCreateTrailerWithNoIntegerMaxHeight

	self 
		shouldRaiseError: [ 
			Trailer with: 100  and: 1.5 
		] 
		withMessage: Trailer heightCapacityMustBeIntegerErrorDescription 
		! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/11/2025 13:58:21'!
test05ShouldRejectProductAIfWeightExceeded

	self setterWithTrailerWithWeight: 20 andHeight: 100. 
	self 
		shouldRaiseError: [ 
			trailer carry: (ProductA with: 21 and: 1) 
			] 
		withMessage: Trailer maxWeightExceededErrorDescription.
	self assert: trailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/11/2025 13:58:28'!
test06ShouldRejectProductBIfWeightExceeded

	self setterWithTrailerWithWeight: 20 andHeight: 100.
	self shouldRaiseError: [ trailer carry: (ProductB with: 21 and: 1) ] withMessage: Trailer maxWeightExceededErrorDescription.
	self assert: trailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/11/2025 13:58:32'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity

	self setterWithTrailerWithWeight: 11 andHeight: 100. 
	
	
	trailer carry: (ProductA with: 1 and: 1).
	trailer carry: (ProductA with: 2 and: 1).
	trailer carry: (ProductB with: 3 and: 1).
	trailer carry: (ProductB with: 4 and: 1).
	
	self assertTrailerTotalProducts: 4 andTotalWeight: 10. 
	! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'mc 4/11/2025 13:58:37'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity

	self setterWithTrailerWithWeight: 11 andHeight: 100. 
	
	
	trailer carry: (ProductA with: 1 and: 1).
	trailer carry: (ProductA with: 2 and: 1).
	trailer carry: (ProductB with: 3 and: 1).
	trailer carry: (ProductB with: 4 and: 1).
	trailer carry: (ProductB with: 1 and: 1).
	
	self assertTrailerTotalProducts: 5 andTotalWeight: 11.
	! !


!TrailerTest methodsFor: 'height capacity' stamp: 'mc 4/11/2025 13:58:46'!
test09ShouldAcceptProductAIgnoringMaxTotalHeightOfBProducts

	|heightCapacity|
	heightCapacity := 100.
	self setterWithTrailerWithWeight: 20  andHeight: heightCapacity.
	
	self calculateHalfExceededHeightCapacity: heightCapacity.
	
	trailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	trailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	
	self assertTrailerTotalProducts: 2  andTotalWeight: 20. 
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'mc 4/11/2025 13:58:54'!
test10ShouldIgnoreAProductsInMaxTotalHeightOfBProducts

	| heightCapacity |

	heightCapacity := 100.
	self setterWithTrailerWithWeight: 20 andHeight: heightCapacity. 
	self calculateHalfExceededHeightCapacity: heightCapacity. 
	
	trailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	trailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).
	
	self assertTrailerTotalProducts: 2  andTotalWeight: 20. 
	
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'mc 4/11/2025 13:59:00'!
test11ShouldRejectProductBExceedingMaxTotalHeightOfBProducts

	|heightCapacity |

	heightCapacity := 100.
	self setterWithTrailerWithWeight: 20 andHeight: heightCapacity. 
	self calculateHalfExceededHeightCapacity: heightCapacity.

	
	
	trailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		shouldRaiseError: [
			trailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)
			]  
		withMessage: Trailer maxHeightExceededErrorDescription.
		
	
	self assertTrailerTotalProducts: 1 andTotalWeight: 10. 
	
	! !



!TrailerTest methodsFor: 'calculate' stamp: 'mc 4/11/2025 12:18:53'!
calculateHalfExceededHeightCapacity: aHeightCapacity

	halfExceededHeightCapacity := (aHeightCapacity+2) / 2.! !


!TrailerTest methodsFor: 'assert' stamp: 'mc 4/10/2025 21:09:14'!
assertTrailerTotalProducts: aNumberOfProducts andTotalWeight: aWeight.
	self assert: trailer totalProductsAmount equals: aNumberOfProducts.
	self assert: trailer totalProductsWeight equals: aWeight.! !


!classDefinition: #Cashier category: #'IRobot-Enunciado'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Cashier methodsFor: 'closing buy order' stamp: 'mc 4/10/2025 19:31:18'!
receiveOrder: aRobot
	
	^(aRobot status) robotDoInCashier: self.
! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !

!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'IRobot-Enunciado'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: #'IRobot-Enunciado'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Product methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 10:39:55'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'IRobot-Enunciado'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:47:40'!
with: aWeight and: aHeight
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^ self new initializeWith: aWeight and: aHeight! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: #'IRobot-Enunciado'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: #'IRobot-Enunciado'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: #'IRobot-Enunciado'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Robot methodsFor: 'actions' stamp: 'mc 4/10/2025 14:55:04'!
closeOrderUsing: aCashier

	^status robotCloseOrderUsing: aCashier
	
	! !

!Robot methodsFor: 'actions' stamp: 'mc 4/10/2025 15:03:08'!
take: aProduct

	^status robotTake: aProduct.
	
! !


!Robot methodsFor: 'status' stamp: 'mc 4/9/2025 23:21:16'!
outOfOrder

	status := OutOfOrder with: self.
! !

!Robot methodsFor: 'status' stamp: 'mc 4/9/2025 23:19:57'!
withMechanicalFailure

	status := MechanicalFailure with: self.
! !

!Robot methodsFor: 'status' stamp: 'mc 4/9/2025 23:19:47'!
withSensorsFailure

	status := SensorsFailure with: self.
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/4/2020 18:35:21'!
status

	^ status
! !

!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'initialization' stamp: 'mc 4/9/2025 15:01:08'!
initializeWith: aTrailer

	trailer := aTrailer.
	status := WorkingNormal with: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'IRobot-Enunciado'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 18:26:04'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 18:26:32'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #Status category: #'IRobot-Enunciado'!
Object subclass: #Status
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Status methodsFor: 'initialize' stamp: 'mc 4/9/2025 15:04:00'!
with: aRobot
	
	robot := aRobot.! !


!Status methodsFor: 'actionsRobot' stamp: 'mc 4/10/2025 14:55:14'!
robotCloseOrderUsing: aCashier
	
	^ aCashier receiveOrder: robot.! !

!Status methodsFor: 'actionsRobot' stamp: 'mc 4/10/2025 14:56:31'!
robotTake: aProduct
	 robot trailer carry: aProduct.! !


!Status methodsFor: 'accessing' stamp: 'mc 4/9/2025 15:15:56'!
trailer

	^robot trailer.! !


!Status methodsFor: 'robotCashier' stamp: 'mc 4/10/2025 19:31:31'!
robotDoInCashier: aCashier 

	aCashier assertTrailerNotEmpty: robot trailer.	
	^ true! !

!Status methodsFor: 'robotCashier' stamp: 'mc 4/10/2025 14:13:51'!
robotInCashierDo: aCashier 

	aCashier assertTrailerNotEmpty: robot trailer.	
	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Status class' category: #'IRobot-Enunciado'!
Status class
	instanceVariableNames: ''!

!Status class methodsFor: 'initialization' stamp: 'mc 4/9/2025 15:06:53'!
with: aRobot
	
	^(self new) with: aRobot.! !


!classDefinition: #MechanicalFailure category: #'IRobot-Enunciado'!
Status subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!MechanicalFailure methodsFor: 'robotCashier' stamp: 'mc 4/10/2025 19:31:51'!
robotDoInCashier: aCashier 

		robot outOfOrder.
		^super robotInCashierDo: aCashier.	
		! !

!MechanicalFailure methodsFor: 'robotCashier' stamp: 'mc 4/10/2025 14:21:57'!
robotInCashierDo: aCashier

		robot outOfOrder.
		^super robotInCashierDo: aCashier.	
		! !


!classDefinition: #OutOfOrder category: #'IRobot-Enunciado'!
Status subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!OutOfOrder methodsFor: 'actionsRobot' stamp: 'mc 4/10/2025 14:55:31'!
robotCloseOrderUsing: aCashier
	
	^ robot class signalOutOfOrder.! !

!OutOfOrder methodsFor: 'actionsRobot' stamp: 'mc 4/10/2025 14:56:41'!
robotTake: aProduct

	^ robot class signalOutOfOrder.! !


!classDefinition: #SensorsFailure category: #'IRobot-Enunciado'!
Status subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!SensorsFailure methodsFor: 'robotCashier' stamp: 'mc 4/10/2025 19:31:57'!
robotDoInCashier: aCashier 

	robot outOfOrder.
	^aCashier signalRobotSensorsFailure.
	! !

!SensorsFailure methodsFor: 'robotCashier' stamp: 'mc 4/10/2025 14:27:00'!
robotInCashierDo: aCashier

	robot outOfOrder.
	^aCashier signalRobotSensorsFailure.
	! !


!classDefinition: #WorkingNormal category: #'IRobot-Enunciado'!
Status subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!classDefinition: #Trailer category: #'IRobot-Enunciado'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'mc 4/10/2025 15:39:57'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"

	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [ | product |
		product := (container at: index).
		(product isStackable) ifTrue: [ total := total +  product height ].
		index := index + 1.	
	].
	
	^total.
	! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/14/2020 10:34:38'!
totalProductsWeight
	
	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [
		total := total + (container at: index) weight.
		index := index + 1.	
	].

	^ total.! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 19:08:17'!
carryProductA: aProduct
	
	self assertWeightAdding: aProduct.
	container add: aProduct.! !

!Trailer methodsFor: 'action' stamp: 'mc 4/10/2025 15:39:23'!
carryProductB: aProduct

	self assertWeightAdding: aProduct.
	self assertHeightAdding: aProduct.
	container add: aProduct.! !


!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:29'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:41'!
assertWeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'mc 4/10/2025 15:24:34'!
assertWeightAndHeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ].
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ].! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'IRobot-Enunciado'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'mc 4/10/2025 15:19:15'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !
