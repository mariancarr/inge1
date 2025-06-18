!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:11'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'MF 11/2/2021 22:34:55'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSoldByTheStore withOccurrences: 0 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'MF 11/2/2021 22:35:25'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemNotSoldByTheStore withOccurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'MF 11/2/2021 22:35:34'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore withOccurrences: 2.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:12:44'!
createCart
	
	^ factory createCart.! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:12:52'!
defaultCatalog
	
	^ factory defaultCatalog ! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:13:03'!
itemNotSoldByTheStore
	
	^ factory itemNotSoldByTheStore! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:13:14'!
itemSoldByTheStore
	
	^ factory itemSoldByTheStore! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:12:20'!
setUp

	factory _ StoreTestObjectFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:02:49'!
test01CantCheckoutEmptyCart
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today
				registeringOn: salesBook 
				withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cantCheckoutEmptyCartErrorDescription.
			self assert: salesBook isEmpty.
			]! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:02:58'!
test02CartsCheckoutTotalEqualsItsItemPrice
	
	| cashier cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor.
	
	self assert: cashier checkout equals: 10.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:03:26'!
test03CartsCheckoutTotalEqualsAllOfItsItemPrice
	
	| cashier cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore withOccurrences: 2.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor.
				
	self assert: cashier checkout equals: 20.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:03:43'!
test04CantCheckoutWithAnExpiredCreditCard
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory expiredCreditCard
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeAnExpiredCreditCardErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:03:55'!
test05CantCheckoutCardWithEmptyName
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory creditCardWithInvalidName
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeACardWithInvalidNameErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:01'!
test06CantCheckoutCardThatOnlyContainsSpaces
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory creditCardWithSpacesName
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeACardWithInvalidNameErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:08'!
test07AddsSaleToSalebookAtCheckout
	
	| cashier cart salesBook total simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor.
	
	total _ cashier checkout.
	
	self assert: salesBook includes: total.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:14'!
test08CheckoutFailsWhenMerchantProcessorReportsStolenCard
	
	| cart cashier salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.

	simulatedMerchantProcessor denyStolenCard.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard 
				on: factory today 
				registeringOn: salesBook
				withMerchantProcessor: simulatedMerchantProcessor.
	
	self 
		should: [ cashier checkout ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotDebitAStolenCardErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:20'!
test09MerchantProcessorRecievesCreditCardAndSalesTotalAtCheckout
	
	| cart cashier salesBook simulatedMerchantProcessor card total |
	
	salesBook _ OrderedCollection new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	card _ factory notExpiredCreditCard.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: card
				on: factory today 
				registeringOn: salesBook
				withMerchantProcessor: simulatedMerchantProcessor.
	
	total _ cashier checkout.
	
	self assert: total equals: simulatedMerchantProcessor totalDebited.
	self assert: card equals: simulatedMerchantProcessor debitedCard.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:28'!
test10CheckoutFailsWhenMerchantProcessorReportsCardWithNoCredit
	
	| cart cashier salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.

	simulatedMerchantProcessor denyCardWithoutCredit.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard 
				on: factory today 
				registeringOn: salesBook
				withMerchantProcessor: simulatedMerchantProcessor.
	
	self 
		should: [ cashier checkout ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotDebitACardWithoutCreditErrorDescription.
			self assert: salesBook isEmpty.
			].! !


!CashierTest methodsFor: 'setup' stamp: 'MF 11/2/2021 22:14:27'!
setUp

	factory _ StoreTestObjectFactory new.! !


!classDefinition: #RestTest category: #TusLibros!
TestCase subclass: #RestTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:51:06'!
restInterfaceWithAcceptAuthenticator

	^ RestInterface withCatalog: factory defaultCatalog withAuthenticator: factory validCredentialAuthenticator! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:52:02'!
restInterfaceWithNotAcceptAuthenticator

	^ RestInterface withCatalog: factory defaultCatalog withAuthenticator: factory invalidCredentialAuthenticator! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:51:07'!
test01ListOfEmptyCartIsEmpty

	|restInterface cartID cartList|
	
	restInterface := self restInterfaceWithAcceptAuthenticator.
	
	cartID := restInterface createCartFor: (factory validUserId) withPassword: 'Password'. 
	
	cartList := restInterface listCart: cartID.
	
	self assert: cartList isEmpty! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:52:02'!
test02CantCreateCartForInvalidCredentials

	|restInterface |
	
	restInterface := self restInterfaceWithNotAcceptAuthenticator.
	
	
	self 
		should: [restInterface createCartFor: (factory validUserId) withPassword: 'NotPassword'] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface errorMessageInvalidCredentials.
				
		]
	! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:51:07'!
test03ListOfCartWithItemsIncludesThemAll

	|restInterface cartID cartList product|
	
	product := factory itemSoldByTheStore. 
	
	restInterface := self restInterfaceWithAcceptAuthenticator.
	
	
	cartID := restInterface createCartFor: (factory validUserId) withPassword: 'Password'. 
	
	restInterface addToCart: cartID product: product quantity: 1.
	
	cartList := restInterface listCart: cartID.
	
	self assert: cartList includes: product
	
	! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:51:07'!
test04CantListInvalidCartId

	|restInterface invalidCartId|
	
	
	invalidCartId := -1.
	
	restInterface := self restInterfaceWithAcceptAuthenticator.
	
	restInterface createCartFor: (factory validUserId) withPassword: 'Password'. 
	
	self 
		should: [restInterface listCart: invalidCartId ]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: RestInterface errorMessageInvalidCartId	
		]
	 
	
	
	
	! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:51:07'!
test05ListingDifferentsCartsGetsDifferentResults

	|restInterface firstCartID secondCartID firstCartList secondCartList product|
	
	product := factory itemSoldByTheStore. 
	
	restInterface := self restInterfaceWithAcceptAuthenticator.
	
	firstCartID := restInterface createCartFor: (factory validUserId) withPassword: 'Password'. 
	restInterface addToCart: firstCartID product: product quantity: 1.
	
	secondCartID := restInterface createCartFor: (factory anotherValidUserId) withPassword: 'anotherValidPassword'.
	restInterface addToCart: secondCartID product: product quantity: 3.
	
	firstCartList := restInterface listCart: firstCartID.
	secondCartList := restInterface listCart: secondCartID .
	
	self assert: (firstCartList occurrencesOf: product) equals: 1.
	self assert: (secondCartList occurrencesOf: product) equals: 3.
	
	! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 12:51:07'!
test06CantAddProductToAnInvalidCartId

	|restInterface invalidCartId product|
	
	
	product := factory itemSoldByTheStore .
	invalidCartId := -1.
	
	restInterface := self restInterfaceWithAcceptAuthenticator.
	
	restInterface createCartFor: (factory validUserId) withPassword: 'Password'. 
	
	self 
		should: [restInterface addToCart: invalidCartId  product:  product quantity: 1 ]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: RestInterface errorMessageInvalidCartId	
		]
	 
	
		
	! !

!RestTest methodsFor: 'tests' stamp: 'mc 6/18/2025 14:35:24'!
test07CantCheckoutWithInvalidCartId

	|restInterface invalidCartId cardNumber|
	
	
	invalidCartId := 2.
	
	restInterface := self restInterfaceWithAcceptAuthenticator.
	cardNumber := factory validCardNumber.
	
	
	self 
		should: [restInterface checkOutCart: invalidCartId withCard:  cardNumber expiratingOn: factory notExpiredMonthOfYear of: 'Lean']  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: RestInterface errorMessageInvalidCartId	
		]
	 
	
		
	! !


!RestTest methodsFor: 'as yet unclassified' stamp: 'mc 6/17/2025 19:45:07'!
setUp

	factory := StoreTestObjectFactory new.! !


!classDefinition: #AuthenticatorSimulator category: #TusLibros!
Object subclass: #AuthenticatorSimulator
	instanceVariableNames: 'validationAnswer boolean booleanAnswer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorSimulator methodsFor: 'initialization' stamp: 'mc 6/18/2025 11:33:50'!
initializeAnswer: aBoolean 
	
	booleanAnswer := aBoolean.! !


!AuthenticatorSimulator methodsFor: 'autheticate' stamp: 'mc 6/18/2025 11:38:05'!
authenticate: anUserId with: aPassword 
	
	^booleanAnswer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthenticatorSimulator class' category: #TusLibros!
AuthenticatorSimulator class
	instanceVariableNames: ''!

!AuthenticatorSimulator class methodsFor: 'instance creation' stamp: 'mc 6/18/2025 11:33:33'!
answer: aBoolean 

	^self new initializeAnswer: aBoolean ! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'LNB 11/1/2021 20:11:40'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItemError ]! !

!Cart methodsFor: 'assertions' stamp: 'LNB 11/1/2021 19:28:08'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self signalInvalidQuantityError ]! !


!Cart methodsFor: 'initialization' stamp: 'LNB 11/1/2021 19:25:49'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	contents := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'LNB 11/1/2021 19:25:49'!
occurrencesOf: anItem

	^contents occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'MF 11/2/2021 22:27:17'!
total
	
	| totalPrice |
	
	totalPrice _ 0.
	self do: [:aProduct | totalPrice _ totalPrice + (	catalog at: aProduct) ].
	
	^totalPrice.! !


!Cart methodsFor: 'testing' stamp: 'LNB 11/1/2021 19:25:49'!
includes: anItem

	^contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'LNB 11/1/2021 19:25:49'!
isEmpty
	
	^contents isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'MF 11/2/2021 22:35:09'!
add: anItem

	^ self add: anItem withOccurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'MF 11/2/2021 22:34:04'!
add: anItem withOccurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	contents add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'signaling' stamp: 'LNB 11/1/2021 19:27:51'!
signalInvalidItemError

	^ self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'signaling' stamp: 'LNB 11/1/2021 19:28:08'!
signalInvalidQuantityError

	^ self error: self invalidQuantityErrorMessage! !


!Cart methodsFor: 'enumerating' stamp: 'MF 11/2/2021 22:27:30'!
do: aBlockClosure 

	contents do: aBlockClosure.! !


!Cart methodsFor: 'listing' stamp: 'mc 6/18/2025 11:30:47'!
listContents
	
	^contents copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartUser category: #TusLibros!
Object subclass: #CartUser
	instanceVariableNames: 'cart user userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartUser methodsFor: 'initialization' stamp: 'mc 6/18/2025 11:26:04'!
initializeCart: aCart for: anUserId 
	
	cart := aCart.
	userId := anUserId.! !


!CartUser methodsFor: 'accesing' stamp: 'mc 6/18/2025 11:30:13'!
cart
	
	^cart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartUser class' category: #TusLibros!
CartUser class
	instanceVariableNames: ''!

!CartUser class methodsFor: 'instance creation' stamp: 'mc 6/18/2025 11:25:55'!
cart: aCart for: anUserId 
	
	^self new initializeCart: aCart for: anUserId ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalogue cartToCheckout creditCard date salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'MF 11/2/2021 23:47:18'!
initializeToCheckout: aCartToCheckout charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor   
	
	cartToCheckout := aCartToCheckout.
	creditCard := aCreditCard.
	date := aDate.

	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'MF 11/3/2021 00:00:16'!
checkout
	
	| total |
	
	total _ cartToCheckout total.
	
	merchantProcessor debit: total on: creditCard.
		
	salesBook add: total.
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'MF 11/2/2021 22:56:57'!
canNotChargeACardWithInvalidNameErrorDescription
	
	^'can not charge a card with invalid name'! !

!Cashier class methodsFor: 'error description' stamp: 'MF 11/2/2021 22:41:13'!
canNotChargeAnExpiredCreditCardErrorDescription

	^'can not charge expired credit card'! !

!Cashier class methodsFor: 'error description' stamp: 'MF 11/3/2021 00:11:44'!
canNotDebitACardWithoutCreditErrorDescription
	
	^'can not debit a card without credit'! !

!Cashier class methodsFor: 'error description' stamp: 'MF 11/2/2021 23:49:28'!
canNotDebitAStolenCardErrorDescription
	
	^'can not debit a stolen credit card'! !

!Cashier class methodsFor: 'error description' stamp: 'LNB 11/1/2021 19:43:29'!
cantCheckoutEmptyCartErrorDescription
	^'Cant checkout an empty cart.'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'MF 11/2/2021 23:46:56'!
toCheckout: aCartToCheckout charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor   
	
	(aCartToCheckout isEmpty) ifTrue: [self error: self cantCheckoutEmptyCartErrorDescription.].
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self canNotChargeAnExpiredCreditCardErrorDescription].
	(aCreditCard hasValidName) ifFalse: [self error: self canNotChargeACardWithInvalidNameErrorDescription].
	
	^self new initializeToCheckout: aCartToCheckout charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MF 11/2/2021 22:50:52'!
initializeOf: aName expiresOn: anExpirationDate 
	
	ownerName := aName.
	expirationDate := anExpirationDate.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MF 11/2/2021 22:54:50'!
isExpiredOn: aDate

	^expirationDate < aDate.! !


!CreditCard methodsFor: 'testing' stamp: 'MF 11/2/2021 23:00:38'!
hasValidName
	
	^ownerName withoutTrailingBlanks isEmpty not! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MF 11/2/2021 22:50:26'!
of: aName expiresOn: anExpirationDate 
	
	^self new initializeOf: aName expiresOn: anExpirationDate.! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'simulatedAction totalDebited debitedCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'changing behaviour' stamp: 'MF 11/3/2021 00:11:31'!
denyCardWithoutCredit

	simulatedAction _ [ :anAmount :aCreditCard | self error: Cashier canNotDebitACardWithoutCreditErrorDescription ].! !

!MerchantProcessorSimulator methodsFor: 'changing behaviour' stamp: 'MF 11/3/2021 00:06:51'!
denyStolenCard
	
	simulatedAction _ [ :anAmount :aCreditCard | self error: Cashier canNotDebitAStolenCardErrorDescription ].! !


!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'MF 11/3/2021 00:08:37'!
debitedCard

	^debitedCard! !

!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'MF 11/3/2021 00:08:31'!
totalDebited

	^totalDebited ! !


!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'MF 11/3/2021 00:06:41'!
debit: anAmount on: aCreditCard.

	^simulatedAction value: anAmount value: aCreditCard.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'MF 11/3/2021 00:06:25'!
initialize

	simulatedAction _ [ :anAmount :aCreditCard | 
		totalDebited _ anAmount.
		debitedCard _ aCreditCard.]! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'carts newId authenticator catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'cart' stamp: 'mc 6/18/2025 11:51:30'!
addToCart: cartID product: aProduct quantity: aQuantityToAdd 
	
	(self cartFor: cartID) add: aProduct withOccurrences: aQuantityToAdd ! !

!RestInterface methodsFor: 'cart' stamp: 'mc 6/18/2025 12:02:01'!
cartFor: cartID

	|cartUser|
	
	
	cartUser := carts at: cartID ifAbsent:[self signalErrorInvalidCartId].
	
	^cartUser cart.
	! !

!RestInterface methodsFor: 'cart' stamp: 'mc 6/18/2025 11:25:23'!
createCartFor: anUserId 
	
	^CartUser cart: (Cart acceptingItemsOf: catalog) for: anUserId! !

!RestInterface methodsFor: 'cart' stamp: 'mc 6/18/2025 11:37:28'!
createCartFor: anUserId withPassword: aPassword
 
	|cartID|
	
	self validateAuthentication: anUserId with: aPassword.
	
	carts at: newId put: (self createCartFor: anUserId). 
	
	cartID := self generateNextID.
	
	^cartID! !

!RestInterface methodsFor: 'cart' stamp: 'mc 6/18/2025 11:27:02'!
generateNextID
	
	|actualId|
	
	actualId := newId.
	newId := newId + 1.
	
	^actualId! !

!RestInterface methodsFor: 'cart' stamp: 'mc 6/18/2025 12:15:56'!
listCart: cartID 
	
	^(self cartFor: cartID ) listContents.
	
	! !


!RestInterface methodsFor: 'authenticate' stamp: 'mc 6/18/2025 11:38:44'!
validateAuthentication: anUserId with: aPassword 
	
	(authenticator authenticate: anUserId with: aPassword) ifFalse:[self signalErrorInvalidCredentials]! !


!RestInterface methodsFor: 'initialization' stamp: 'mc 6/18/2025 11:22:27'!
initializeWithCatalog: aCatalog 
	
	newId  := 1.
	catalog := aCatalog.
	carts := Dictionary new.! !

!RestInterface methodsFor: 'initialization' stamp: 'mc 6/18/2025 11:35:08'!
initializeWithCatalog: aCatalog withAuthenticator: anAuthenticator
	
	authenticator := anAuthenticator .
	newId  := 1.
	catalog := aCatalog.
	carts := Dictionary new.! !


!RestInterface methodsFor: 'error' stamp: 'mc 6/18/2025 12:02:27'!
signalErrorInvalidCartId
	
	self error: self class errorMessageInvalidCartId! !

!RestInterface methodsFor: 'error' stamp: 'mc 6/18/2025 11:39:38'!
signalErrorInvalidCredentials
	
	self error: self class errorMessageInvalidCredentials! !


!RestInterface methodsFor: 'checkout' stamp: 'mc 6/18/2025 14:22:55'!
checkOutCart: aCartId 
	
	(self cartFor: aCartId) ! !

!RestInterface methodsFor: 'checkout' stamp: 'mc 6/18/2025 14:43:31'!
checkOutCart: aCartId withCard: aCardNumber expiratingOn: aMonthYear of: aName

	
	 self cartFor: aCartId.
	

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'mc 6/18/2025 11:21:58'!
withCatalog: aCatalog

	^self new initializeWithCatalog: aCatalog ! !

!RestInterface class methodsFor: 'instance creation' stamp: 'mc 6/18/2025 11:34:38'!
withCatalog: aCatalog withAuthenticator: anAuthenticator

	^self new initializeWithCatalog: aCatalog withAuthenticator: anAuthenticator  ! !


!RestInterface class methodsFor: 'error' stamp: 'mc 6/18/2025 12:03:50'!
errorMessageInvalidCartId
	
	^'Cart ID doesnt exists'! !

!RestInterface class methodsFor: 'error' stamp: 'mc 6/18/2025 11:40:28'!
errorMessageInvalidCredentials
	
	^'Username or Password is invalid'! !


!classDefinition: #StoreTestObjectFactory category: #TusLibros!
Object subclass: #StoreTestObjectFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectFactory methodsFor: 'initialization' stamp: 'MF 11/2/2021 22:10:48'!
initialize

	today _ FixedGregorianDate today.! !


!StoreTestObjectFactory methodsFor: 'cart creation' stamp: 'mc 6/18/2025 12:10:21'!
anotherValidUserId
	
	^0002! !

!StoreTestObjectFactory methodsFor: 'cart creation' stamp: 'MF 11/2/2021 22:10:57'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !


!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:52:24'!
creditCardWithInvalidName

	^ CreditCard of: '' expiresOn: self notExpiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:59:07'!
creditCardWithSpacesName

	^ CreditCard of: '  ' expiresOn: self notExpiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:52:34'!
expiredCreditCard

	^ CreditCard of: 'Lean' expiresOn: self expiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:52:24'!
notExpiredCreditCard
	
	^ CreditCard of: 'Lean' expiresOn: self notExpiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'mc 6/18/2025 14:32:31'!
validCardNumber
	
	^4452161102055613! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'mc 6/18/2025 12:10:31'!
validUserId
	
	^0001! !


!StoreTestObjectFactory methodsFor: 'catalog creation' stamp: 'MF 11/2/2021 22:13:56'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSoldByTheStorePrice;
		yourself.! !


!StoreTestObjectFactory methodsFor: 'expiration dates creation' stamp: 'MF 11/2/2021 22:52:34'!
expiredMonthOfYear.

	^(today previous: 1*month) monthOfYear.! !

!StoreTestObjectFactory methodsFor: 'expiration dates creation' stamp: 'MF 11/2/2021 22:52:24'!
notExpiredMonthOfYear

	^(today next: 1*month) monthOfYear.! !


!StoreTestObjectFactory methodsFor: 'accessing' stamp: 'MF 11/2/2021 22:18:10'!
today

	^today.! !


!StoreTestObjectFactory methodsFor: 'item creation' stamp: 'MF 11/2/2021 22:11:39'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!StoreTestObjectFactory methodsFor: 'item creation' stamp: 'MF 11/2/2021 22:11:33'!
itemSoldByTheStore
	
	^ 'validBook'! !

!StoreTestObjectFactory methodsFor: 'item creation' stamp: 'MF 11/2/2021 22:15:07'!
itemSoldByTheStorePrice

	^ 10.! !


!StoreTestObjectFactory methodsFor: 'autheticator' stamp: 'mc 6/18/2025 11:33:24'!
invalidCredentialAuthenticator
	
	^AuthenticatorSimulator answer: false! !

!StoreTestObjectFactory methodsFor: 'autheticator' stamp: 'mc 6/18/2025 11:44:30'!
validCredentialAuthenticator
	
	^AuthenticatorSimulator answer: true.! !
