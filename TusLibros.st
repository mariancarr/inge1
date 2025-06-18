!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:35:16'!
createCart
	
	^factory createCart! !

!CartTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:35:25'!
defaultCatalog
	
	^ factory defaultCatalog ! !

!CartTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:35:34'!
itemNotSellByTheStore
	
	^factory itemNotSellByTheStore ! !

!CartTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:35:40'!
itemSellByTheStore
	
	^ factory itemSellByTheStore ! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:17:25'!
test01CanNotCheckOutEmptyCart
	
	|cart creditCard salesBook merchantProccesor |
	
	salesBook := OrderedCollection new.
	creditCard := factory notExpiredCreditCard.
	cart := factory createCart.	
	
	merchantProccesor := MerchantProccesorSimulator new.
	
	self 
		should:[Cashier forCart: cart withCreditCard: creditCard registerOn: salesBook with: merchantProccesor .  ]  
		raise: Error  
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier errorMessageCanNotCheckoutEmptyCart.	
		] 
	! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/7/2021 16:38:28'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self merchantProcessorSimulator
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/7/2021 16:39:35'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self merchantProcessorSimulator
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:17:07'!
test02CanCheckOutCartWithOneBook
	
	|cart cashier priceBook creditCard salesBook merchantProccesor |
	
	salesBook := OrderedCollection new.
	creditCard := factory notExpiredCreditCard.
	priceBook := factory priceOfItemSellByStore.
	cart := factory createCart.
	cart add: factory itemSellByTheStore.
	
	
	merchantProccesor := MerchantProccesorSimulator new.
	cashier := Cashier forCart: cart withCreditCard: creditCard registerOn: salesBook with: merchantProccesor .  
	
	self assert: (cashier checkout) equals: priceBook.
	! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:16:58'!
test03CanCheckOutCartWithMultipleBooks
	
	|cart cashier priceBook priceAnotherBook creditCard salesBook merchantProccesor |
	
	salesBook := OrderedCollection new.
	creditCard := factory notExpiredCreditCard.
	priceBook := factory priceOfItemSellByStore.
	priceAnotherBook := factory priceOfAnotherItemSellByStore. 
	cart := factory createCart.
	cart add: 2 of: factory itemSellByTheStore; add: factory anotherItemSellByTheStore .
	
	
	merchantProccesor := MerchantProccesorSimulator new.
	cashier := Cashier forCart: cart withCreditCard: creditCard registerOn: salesBook with: merchantProccesor .  
	
	self assert: (cashier checkout) equals: (priceBook*2 + priceAnotherBook).
	! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/7/2021 16:39:40'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self merchantProcessorSimulator 
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:16:32'!
test04CanNotCheckOutWithExpiredCard
	
	|cart salesBook  card merchantProccesor | 
	
	salesBook := OrderedCollection new.
	card := factory expiredCard.
	cart := factory createCart.
	cart add: factory itemSellByTheStore .
	merchantProccesor := MerchantProccesorSimulator new.
	self 
		should:[Cashier forCart:  cart withCreditCard: card registerOn: salesBook with: merchantProccesor ]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier errorMessageCanNotCheckoutWithExpiredCard 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/7/2021 16:39:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self merchantProcessorSimulator
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:16:15'!
test05CanNotCheckOutWithCardWithEmptyName
	
	|salesBook cart card merchantProccesor | 
	
	salesBook := OrderedCollection new.
	card := factory emptyNameCard.
	cart := factory createCart.
	cart add: factory itemSellByTheStore .
	merchantProccesor := MerchantProccesorSimulator new.
	self 
		should:[Cashier forCart: cart withCreditCard: card registerOn: salesBook with: merchantProccesor]  
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier errorMessageCanNotCheckoutWithInvalidNameCard 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/7/2021 16:40:01'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self merchantProcessorSimulator 
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:15:56'!
test06AllSalesAreRegistered
	
	|cart cashier  card salesBook total merchantProccesor | 
	
	salesBook := OrderedCollection new.
	card := factory notExpiredCreditCard .
	cart := factory createCart.
	cart add: factory itemSellByTheStore .
	
	
	merchantProccesor := MerchantProccesorSimulator new.
	cashier := Cashier forCart: cart withCreditCard: card registerOn: salesBook with: merchantProccesor.
	
	total := cashier checkout.
	
	self assert: (salesBook includes: total)
	! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/7/2021 16:40:20'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self merchantProcessorSimulator 
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:23:40'!
test07MerchanProccesorReceivesCreditCardAndTotalPriceAtCheckOut
	
	|cart cashier  card salesBook total merchantProccesor| 
	
	salesBook := OrderedCollection new.
	card := factory notExpiredCreditCard .
	cart := factory createCart.
	cart add: factory itemSellByTheStore .
	
	merchantProccesor := MerchantProccesorSimulator new.
	cashier := Cashier forCart: cart withCreditCard: card registerOn: salesBook with: merchantProccesor .  
	
	total := cashier checkout.
	
	self assert: (merchantProccesor paymentCard) equals: card.
	self assert: (merchantProccesor paymentAmount) equals: total.
	! !

!CashierTest methodsFor: 'tests' stamp: 'mc 6/14/2025 18:27:01'!
test08MerchanProccesorRejectsWhenInsuficientFundsInCard
	
	|cart cashier  card salesBook merchantProccesor| 
	
	salesBook := OrderedCollection new.
	card := factory notExpiredCreditCard .
	cart := factory createCart.
	cart add: factory itemSellByTheStore .
	
	merchantProccesor := MerchantProccesorSimulator new.
	merchantProccesor insuficientFundsSimulatedAction.
	
	cashier := Cashier forCart: cart withCreditCard: card registerOn: salesBook with: merchantProccesor .  
	
	self 
		should:[cashier checkout]  
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: MerchantProccesorSimulator errorMessageInsuficientFunds.
			self assert: salesBook isEmpty	
		]
	
	! !


!CashierTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:40:47'!
createCart
	
	^factory createCart! !

!CashierTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:40:54'!
defaultCatalog
	
	^ factory defaultCatalog ! !

!CashierTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:41:00'!
itemNotSellByTheStore
	
	^factory itemNotSellByTheStore ! !

!CashierTest methodsFor: 'support' stamp: 'mc 6/14/2025 11:41:06'!
itemSellByTheStore
	
	^ factory itemSellByTheStore ! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'merchant processor creation' stamp: 'MF 11/7/2021 16:39:19'!
merchantProcessorSimulator

	^MerchantProcessorSimulator withBehaviour: debitBehavior.! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:28:43'!
test01ListOfEmptyCartIsEmpty

	| cartContents cartId interface |
	interface _ self restInterface.
	
	cartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	cartContents _ interface listCart: cartId.
	
	self assert: cartContents isEmpty.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:30:10'!
test02CantCreateCartWithInvalidCredentials

	| interface |
	interface _ self notAuthenticatingRestInterface.
	
	self
		should: [ interface createCartFor: testObjectsFactory validUserId with: 'Password' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[ :anError | 
				self assert: anError messageText equals: RestInterface usernameOrPasswordIsInvalidErrorMessage ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:30:37'!
test03ListOfCartWithAnItemIncludesThatItem

	| cartContents cartId interface product |
	interface _ self restInterface.
	cartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	product _ testObjectsFactory itemSellByTheStore.
	
	interface addToCart: cartId product: product withOccurrences: 1.
	
	cartContents _ interface listCart: cartId.
	
	self assert: cartContents includes: product.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 18:04:33'!
test04ListingDifferentCartsReturnsDifferentResults

	| interface product cart1Contents cart2Contents cartId1 cartId2 |
	interface _ self restInterface.
	cartId1 _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	cartId2 _ interface createCartFor: testObjectsFactory anotherValidUserId with: 'Password2'.
	 
	product _ testObjectsFactory itemSellByTheStore.
	
	interface addToCart: cartId1 product: product withOccurrences: 1.
	interface addToCart: cartId2 product: product  withOccurrences: 2.
	
	cart1Contents _ interface listCart: cartId1.
	cart2Contents _ interface listCart: cartId2.
	
	self assert: 1 equals: (cart1Contents occurrencesOf: product).
	self assert: 2 equals: (cart2Contents occurrencesOf: product).! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:30:59'!
test05CantListWithAnInvalidCartId

	| interface invalidCartId |
	interface _ self restInterface.
	
	invalidCartId _ 1.
	
	self
		should: [ interface listCart: invalidCartId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[ :anError | 
				self assert: anError messageText equals: RestInterface cartIdDoesNotExistErrorMessage ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:31:11'!
test06CantAddToCartWithInvalidCartId

	| interface invalidCartId |
	interface _ self restInterface.
	
	invalidCartId _ 1.
	
	self
		should: [ interface addToCart: invalidCartId product: testObjectsFactory itemSellByTheStore withOccurrences: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[ :anError | 
				self assert: anError messageText equals: RestInterface cartIdDoesNotExistErrorMessage ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:31:31'!
test07CantCheckoutCartWithInvalidCartId

	| interface invalidCartId creditCardNumber |
	interface _ self restInterface.
	
	invalidCartId _ 1.
	creditCardNumber _ testObjectsFactory validCCNumber.
	
	self
		should: [ interface 
					checkOutCart: invalidCartId 
					with: creditCardNumber
					of: 'Lean' 
					expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[ :anError | 
				self assert: anError messageText equals: RestInterface cartIdDoesNotExistErrorMessage ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 22:56:11'!
test08ListOfPurchasesOfUserWithNoPurchasesIsEmpty

	| interface purchases |
	interface _ self restInterface.
	
	purchases _ interface listPurchasesOf: testObjectsFactory validUserId with: 'Password'.
	
	self assert: purchases products isEmpty.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:32:05'!
test09CantListPurchasesWithInvalidCredentials

	| interface |
	interface _ self notAuthenticatingRestInterface.
	
	self
		should: [ interface listPurchasesOf: testObjectsFactory validUserId with: 'Password' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[ :anError | 
				self assert: anError messageText equals: RestInterface usernameOrPasswordIsInvalidErrorMessage ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 22:56:44'!
test10ListOfPurchasesOfUserWithAPurchaseIncludesThatPurchase

	| interface purchases cartId product |
	interface _ self restInterface.
	
	cartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	product _ testObjectsFactory itemSellByTheStore.
	interface addToCart: cartId product: product withOccurrences: 3.
	interface 
		checkOutCart: cartId 
		with: testObjectsFactory validCCNumber 
		of: 'Card Owner' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases _ interface listPurchasesOf: testObjectsFactory validUserId with: 'password'.
	
	self assert: (testObjectsFactory itemSellByTheStorePrice * 3) equals: purchases total.
	self assert: 3 equals: (purchases products occurrencesOf: product).
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:47:23'!
test11CantListAnExpiredCart

	self assertCantDoOnAnExpiredCart: [ :anInterface :aCartId | anInterface listCart: aCartId ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:48:33'!
test12CantAddToAnExpiredCart

	self assertCantDoOnAnExpiredCart: [  
		:anInterface :aCartId | anInterface addToCart: aCartId 
								product: testObjectsFactory itemSellByTheStore 
								withOccurrences: 1 ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:49:14'!
test13CantCheckoutAnExpiredCart
	
	self assertCantDoOnAnExpiredCart: [ :anInterface :aCartId |
		 anInterface checkOutCart: aCartId 
				with: testObjectsFactory validCCNumber 
				of: 'Owner' 
				expiringOn: testObjectsFactory notExpiredMonthOfYear ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/9/2021 17:34:27'!
test14ExpireTimeOfCartIsRefreshedAfterUse

	| interface cartId clock |
	clock _ Clock new.
	interface _ RestInterface authenticatingWith: (AuthenticatingSystemSimulator with: true) 
				withCatalog: testObjectsFactory defaultCatalog 
				withMP: testObjectsFactory validMerchantProcessorSimulator
				withClock: clock.
	
	cartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'. 
	clock skipAhead: 29*minute.
	interface addToCart: cartId product: testObjectsFactory itemSellByTheStore withOccurrences: 1.
	clock skipAhead: 1*minute. 	
	
	self assert: (interface listCart: cartId) includes: testObjectsFactory itemSellByTheStore.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/10/2021 22:47:02'!
test15ListingPurchasesOfDifferentUsersReturnsDifferentPurchases

	| interface product cartId1 cartId2 purchases1 purchases2 |
	interface _ self restInterface.
	cartId1 _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	cartId2 _ interface createCartFor: testObjectsFactory anotherValidUserId with: 'Password2'.
	 
	product _ testObjectsFactory itemSellByTheStore.
	
	interface addToCart: cartId1 product: product withOccurrences: 1.
	interface addToCart: cartId2 product: product  withOccurrences: 2.
	
	self checkoutOn: interface cartIdentifiedAs: cartId1.
	self checkoutOn: interface cartIdentifiedAs: cartId2.
	
	purchases1 _ interface listPurchasesOf: testObjectsFactory validUserId with: 'Password'.
	purchases2 _ interface listPurchasesOf: testObjectsFactory anotherValidUserId with: 'Password'.
	
	self assert: 1 equals: (purchases1 products occurrencesOf: product).
	self assert: 2 equals: (purchases2 products occurrencesOf: product)! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'MF 11/10/2021 22:47:24'!
test16ListingPurchasesOfUserWithMoreThanOneCheckoutReturnsPurchasesOfAllCheckouts

	| interface purchases cartId product anotherCartId |
	interface _ self restInterface.
	
	cartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	product _ testObjectsFactory itemSellByTheStore.
	interface addToCart: cartId product: product withOccurrences: 3.
	interface 
		checkOutCart: cartId 
		with: testObjectsFactory validCCNumber 
		of: 'Card Owner' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	anotherCartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'.
	interface addToCart: anotherCartId product: product withOccurrences: 3.
	interface 
		checkOutCart: anotherCartId 
		with: testObjectsFactory validCCNumber 
		of: 'Card Owner' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases _ interface listPurchasesOf: testObjectsFactory validUserId with: 'password'.
	
	self assert: (testObjectsFactory itemSellByTheStorePrice * 6) equals: purchases total.
	self assert: 6 equals: (purchases products occurrencesOf: product).
	
	! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'MF 11/4/2021 20:07:55'!
setUp

	testObjectsFactory _ StoreTestObjectsFactory new.! !


!RestInterfaceTest methodsFor: 'interface creation' stamp: 'MF 11/9/2021 16:12:04'!
notAuthenticatingRestInterface

	^ RestInterface authenticatingWith: (AuthenticatingSystemSimulator with: false) 
					withCatalog: testObjectsFactory defaultCatalog 
					withMP: testObjectsFactory validMerchantProcessorSimulator 
					withClock: testObjectsFactory clock.! !

!RestInterfaceTest methodsFor: 'interface creation' stamp: 'MF 11/9/2021 16:12:04'!
restInterface

	^ RestInterface authenticatingWith: (AuthenticatingSystemSimulator with: true) 
					withCatalog: testObjectsFactory defaultCatalog 
					withMP: testObjectsFactory validMerchantProcessorSimulator
					withClock: testObjectsFactory clock.! !


!RestInterfaceTest methodsFor: 'auxiliaries' stamp: 'MF 11/9/2021 17:59:13'!
assertCantDoOnAnExpiredCart: aBlock

	| interface cartId clock |
	clock _ Clock new.
	interface _ RestInterface authenticatingWith: (AuthenticatingSystemSimulator with: true) 
				withCatalog: testObjectsFactory defaultCatalog 
				withMP: testObjectsFactory validMerchantProcessorSimulator
				withClock: clock.
	
	cartId _ interface createCartFor: testObjectsFactory validUserId with: 'Password'. 
	clock skipAhead: 30*minute .
	
	self
		should: [ aBlock value: interface value: cartId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: 
			[ :anError | 
				self assert: anError messageText equals: RestInterface cartIdDoesNotExistErrorMessage ].! !

!RestInterfaceTest methodsFor: 'auxiliaries' stamp: 'MF 11/9/2021 18:07:06'!
checkoutOn: anInterface cartIdentifiedAs: aCartId

	^ anInterface 
		checkOutCart: aCartId 
		with: testObjectsFactory validCCNumber 
		of: 'Card Owner' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear! !


!classDefinition: #AuthenticatingSystemSimulator category: #TusLibros!
Object subclass: #AuthenticatingSystemSimulator
	instanceVariableNames: 'booleanToReturn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatingSystemSimulator methodsFor: 'initialization' stamp: 'MF 11/4/2021 19:58:15'!
initializeWith: aBooleanToReturnWhenAuthenticating 
	
	booleanToReturn := aBooleanToReturnWhenAuthenticating.! !


!AuthenticatingSystemSimulator methodsFor: 'authenticating system protocol' stamp: 'MF 11/4/2021 20:03:56'!
authenticate: aUsername with: aPassword 
	
	^booleanToReturn ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthenticatingSystemSimulator class' category: #TusLibros!
AuthenticatingSystemSimulator class
	instanceVariableNames: ''!

!AuthenticatingSystemSimulator class methodsFor: 'instance creation' stamp: 'MF 11/4/2021 19:57:56'!
with: aBooleanToReturnWhenAuthenticating 

	^self new initializeWith: aBooleanToReturnWhenAuthenticating.! !


!classDefinition: #BookStoreTestObjectFactory category: #TusLibros!
Object subclass: #BookStoreTestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookStoreTestObjectFactory methodsFor: 'catalog create' stamp: 'mc 6/14/2025 12:18:03'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!BookStoreTestObjectFactory methodsFor: 'catalog create' stamp: 'mc 6/14/2025 12:38:43'!
defaultCatalog
	
	|catalogDictionary|
	
	catalogDictionary := Dictionary new.
	
	catalogDictionary at: self itemSellByTheStore put: self priceOfItemSellByStore; at: self anotherItemSellByTheStore put: self priceOfAnotherItemSellByStore.
	
	^catalogDictionary ! !

!BookStoreTestObjectFactory methodsFor: 'catalog create' stamp: 'mc 6/14/2025 11:32:49'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!BookStoreTestObjectFactory methodsFor: 'catalog create' stamp: 'mc 6/14/2025 11:32:36'!
itemSellByTheStore
	
	^ 'validBook'! !

!BookStoreTestObjectFactory methodsFor: 'catalog create' stamp: 'mc 6/14/2025 12:18:20'!
priceOfAnotherItemSellByStore
	
	^250.! !

!BookStoreTestObjectFactory methodsFor: 'catalog create' stamp: 'mc 6/14/2025 11:48:37'!
priceOfItemSellByStore

	^ 100! !


!BookStoreTestObjectFactory methodsFor: 'cart create' stamp: 'mc 6/14/2025 12:38:53'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog ! !


!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 15:42:11'!
emptyNameCard
	
	^CreditCard for: '' withExpiration: self notExpiratedDate ! !

!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 14:42:57'!
expiratedDate
	|today|
	
	today := FixedGregorianDate today.
	
	^(today previous: 1* month) .
	
	! !

!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 13:27:18'!
expiredCard
	
	^CreditCard for: self ownerName withExpiration: self expiratedDate ! !

!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 15:33:53'!
notExpiratedDate
	
	|today|
	
	today := GregorianMonthOfYear current.
	
	^(today next: 2*month)! !

!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 15:22:59'!
notExpiredCreditCard

	^CreditCard for: self ownerName withExpiration: self notExpiratedDate ! !

!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 13:28:01'!
ownerName
	
	^'Mariano'! !

!BookStoreTestObjectFactory methodsFor: 'card create' stamp: 'mc 6/14/2025 15:49:33'!
spacesNameCard
	
	^CreditCard for: ' ' withExpiration: self notExpiratedDate ! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'MF 11/4/2021 20:28:35'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	contents := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'MF 11/4/2021 20:28:10'!
occurrencesOf: anItem

	^contents occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'mc 6/14/2025 12:35:31'!
totalValue
	
	|total|
	
	total := 0.
	
	items associationsDo: [:book | 
		total := total + (catalog at: book)	
	].

	^total.! !


!Cart methodsFor: 'testing' stamp: 'MF 11/4/2021 20:28:10'!
includes: anItem

	^contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'MF 11/4/2021 20:28:10'!
isEmpty
	
	^contents isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'MF 11/4/2021 20:29:01'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	contents add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'total' stamp: 'MF 11/4/2021 20:28:10'!
total

	^ contents sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'MF 11/4/2021 20:28:10'!
contents

	^contents copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartOfCustomer category: #TusLibros!
Object subclass: #CartOfCustomer
	instanceVariableNames: 'cart timeLastUsed userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartOfCustomer methodsFor: 'initialization' stamp: 'MF 11/9/2021 18:17:35'!
initializeFor: aCart atPointInTime: aDateTime belongingToUserIdentifiedAs: anUserId  
	
	cart := aCart.
	timeLastUsed := aDateTime.
	userId := anUserId.! !


!CartOfCustomer methodsFor: 'accessing' stamp: 'MF 11/8/2021 20:03:50'!
cart

	^cart! !

!CartOfCustomer methodsFor: 'accessing' stamp: 'MF 11/9/2021 18:17:47'!
userId

	^userId.! !


!CartOfCustomer methodsFor: 'testing' stamp: 'MF 11/8/2021 20:10:38'!
stillValidAt: aDateTime

	^aDateTime < (timeLastUsed next: 30*minute).! !


!CartOfCustomer methodsFor: 'updating' stamp: 'MF 11/8/2021 20:29:22'!
touch: aDateTime 
	
	timeLastUsed _ aDateTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartOfCustomer class' category: #TusLibros!
CartOfCustomer class
	instanceVariableNames: ''!

!CartOfCustomer class methodsFor: 'instance creation' stamp: 'MF 11/9/2021 18:17:09'!
for: aCart atPointInTime: aDateTime belongingToUserIdentifiedAs: anUserId  
	
	^self new initializeFor: aCart atPointInTime: aDateTime belongingToUserIdentifiedAs: anUserId ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !

!Cashier methodsFor: 'checkout' stamp: 'mc 6/14/2025 18:21:54'!
checkout
	
	|total|
	
	total := cart totalValue.
	merchantProccesor charge: total on: creditCard. 
	
	salesBook add: total.
	
	^total
	! !


!Cashier methodsFor: 'initialization' stamp: 'mc 6/14/2025 18:15:25'!
initializeForCart: aCart withCreditCard: aCreditCard registerOn: aSalesBook with: aMerchantProccesor
	
	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook.
	merchantProccesor := aMerchantProccesor ! !

!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !


!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MF 11/9/2021 22:24:50'!
createSale

	^ Sale of: total withProducts: cart contents
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'mc 6/14/2025 17:14:07'!
errorMessageCanNotCheckoutEmptyCart
	
	^'Can not cehckout empty cart'! !

!Cashier class methodsFor: 'error' stamp: 'mc 6/14/2025 17:14:20'!
errorMessageCanNotCheckoutWithExpiredCard
	
	^'Can not check out with expired Credit Card'! !

!Cashier class methodsFor: 'error' stamp: 'mc 6/14/2025 17:14:13'!
errorMessageCanNotCheckoutWithInvalidNameCard
	
	^'Cant checkout with credit card which name is invalid'! !

!Cashier class methodsFor: 'error' stamp: 'mc 6/14/2025 17:15:05'!
signalErrorCardExpired

	^ self error: self errorMessageCanNotCheckoutWithExpiredCard! !

!Cashier class methodsFor: 'error' stamp: 'mc 6/14/2025 17:19:17'!
signalErrorEmptyCart

	^ self error: self  errorMessageCanNotCheckoutEmptyCart! !

!Cashier class methodsFor: 'error' stamp: 'mc 6/14/2025 17:14:52'!
signalErrorInvalidCardName

	^ self error: self errorMessageCanNotCheckoutWithInvalidNameCard! !


!Cashier class methodsFor: 'instance creation' stamp: 'mc 6/14/2025 18:14:46'!
forCart: aCart withCreditCard: aCreditCard registerOn: aSalesBook with: aMerchantProccesor
	
	
	self assertCartNotEmpty: aCart.
	self assertCardIsNotExpired: aCreditCard.
	self assertCardHasValidName: aCreditCard.

	^self new initializeForCart: aCart withCreditCard: aCreditCard registerOn: aSalesBook with: aMerchantProccesor  ! !

!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'assert' stamp: 'mc 6/14/2025 17:14:52'!
assertCardHasValidName: aCreditCard

	^ aCreditCard hasValidName ifFalse:[self signalErrorInvalidCardName ]! !

!Cashier class methodsFor: 'assert' stamp: 'mc 6/14/2025 17:15:06'!
assertCardIsNotExpired: aCreditCard

	^ aCreditCard isExpired ifTrue:[self signalErrorCardExpired ]! !

!Cashier class methodsFor: 'assert' stamp: 'mc 6/14/2025 17:15:18'!
assertCartNotEmpty: aCart

	^ aCart isEmpty ifTrue:[self signalErrorEmptyCart]! !


!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: 'timeOffset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'initialization' stamp: 'MF 11/8/2021 19:47:38'!
initialize

	timeOffset _ 0.! !


!Clock methodsFor: 'global clock' stamp: 'MF 11/8/2021 19:50:05'!
globalClock

	^GregorianDateTime now! !


!Clock methodsFor: 'clock protocol' stamp: 'MF 11/8/2021 20:02:05'!
now

	^self globalClock next: timeOffset .! !


!Clock methodsFor: 'private - time skipping' stamp: 'MF 11/9/2021 17:51:42'!
skipAhead: anAmountOfTime

	timeOffset _ timeOffset + anAmountOfTime.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'mc 6/14/2025 14:44:24'!
initializeFor: aName withExpiration: aDate 
	
	name := aName.
	expiration := aDate.! !


!CreditCard methodsFor: 'testing' stamp: 'mc 6/14/2025 16:00:00'!
hasValidName
	
	|nameWithoutSpaces|
	
	nameWithoutSpaces := name select:[:char | (char  = Character space) not].
	^(nameWithoutSpaces isEmpty) not! !

!CreditCard methodsFor: 'testing' stamp: 'mc 6/14/2025 15:17:55'!
isExpired
	
	^(expiration < FixedGregorianDate today)! !

!CreditCard methodsFor: 'testing' stamp: 'MF 11/7/2021 15:21:31'!
isExpiredOn: aDate 
	
	^expiration < aDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'mc 6/14/2025 14:43:53'!
for: aName withExpiration: aDate 
	
	^self new initializeFor: aName withExpiration: aDate ! !


!classDefinition: #CustomerPurchaseHistory category: #TusLibros!
Object subclass: #CustomerPurchaseHistory
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CustomerPurchaseHistory methodsFor: 'adding' stamp: 'MF 11/9/2021 22:47:19'!
add: aSale

	sales add: aSale.! !


!CustomerPurchaseHistory methodsFor: 'initialization' stamp: 'MF 11/9/2021 22:38:57'!
initialize

	sales _ OrderedCollection new! !


!CustomerPurchaseHistory methodsFor: 'accesing' stamp: 'MF 11/9/2021 22:43:09'!
products

	| bagOfProducts |
	
	bagOfProducts _ Bag new.
	sales do: [ :aSale | bagOfProducts addAll: aSale products ].
	^bagOfProducts ! !

!CustomerPurchaseHistory methodsFor: 'accesing' stamp: 'MF 11/9/2021 22:48:05'!
total

	^sales sum: [ :aSale | aSale total ].! !


!classDefinition: #MerchantProccesorSimulator category: #TusLibros!
Object subclass: #MerchantProccesorSimulator
	instanceVariableNames: 'paymentCard paymentAmount simulatedAction a'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProccesorSimulator methodsFor: 'initialization' stamp: 'mc 6/14/2025 18:29:51'!
initialize
	
	simulatedAction := [:aPaymentCard :anAmount | paymentCard := aPaymentCard . paymentAmount := anAmount ].! !


!MerchantProccesorSimulator methodsFor: 'payment' stamp: 'mc 6/14/2025 18:22:47'!
charge: anAmount on: aPaymentCard 
	
	simulatedAction value: aPaymentCard value: anAmount! !


!MerchantProccesorSimulator methodsFor: 'accesing' stamp: 'mc 6/14/2025 18:24:02'!
paymentAmount
	
	^paymentAmount! !

!MerchantProccesorSimulator methodsFor: 'accesing' stamp: 'mc 6/14/2025 18:23:55'!
paymentCard
	
	^paymentCard! !


!MerchantProccesorSimulator methodsFor: 'simulate' stamp: 'mc 6/14/2025 18:28:54'!
insuficientFundsSimulatedAction
	
	simulatedAction  := [:aPaymentCard :anAmount | self error: self class errorMessageInsuficientFunds]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProccesorSimulator class' category: #TusLibros!
MerchantProccesorSimulator class
	instanceVariableNames: ''!

!MerchantProccesorSimulator class methodsFor: 'error' stamp: 'mc 6/14/2025 18:29:22'!
errorMessageInsuficientFunds
	
	^'Insuficient funds'! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'MF 11/7/2021 16:35:51'!
initializeWithBehaviour: aBlock

	debitBehaviour _ aBlock.
! !


!MerchantProcessorSimulator methodsFor: 'merchant processor protocol' stamp: 'MF 11/7/2021 16:36:08'!
debit: anAmount from: aCreditCard

	debitBehaviour value: anAmount value: aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'MF 11/7/2021 16:35:36'!
withBehaviour: aBlock

	^self new initializeWithBehaviour: aBlock.! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticatingSystem catalog currentCarts newId customerPurchases merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'MF 11/9/2021 22:58:09'!
initializeAuthenticatingWith: anAuthenticatingSystem withCatalog: aCatalog withMP: aMerchantProcessor withClock: aClock    
	
	authenticatingSystem := anAuthenticatingSystem.
	catalog := aCatalog.
	
	newId _ 1.
	currentCarts _ Dictionary new.
	customerPurchases _ Dictionary new.
	merchantProcessor _ aMerchantProcessor.
	clock _ aClock.! !


!RestInterface methodsFor: 'adding' stamp: 'MF 11/7/2021 15:30:06'!
addToCart: aCartId product: aProduct withOccurrences: aQuantity

	(self cartWithId: aCartId) add: aQuantity of: aProduct.
	
	! !


!RestInterface methodsFor: 'authenticating' stamp: 'MF 11/9/2021 18:24:08'!
authenticate: aUserId with: aPassword

	^ (authenticatingSystem authenticate: aUserId with: aPassword) 
		ifFalse: [ self signalUsernameOrPasswordIsInvalid ]! !


!RestInterface methodsFor: 'error signaling' stamp: 'MF 11/9/2021 17:38:57'!
signalAndDeleteInvalidCart: aCartId

	currentCarts removeKey: aCartId.
	self signalCartIdIsInvalid! !

!RestInterface methodsFor: 'error signaling' stamp: 'MF 11/4/2021 20:46:13'!
signalCartIdIsInvalid

	^ self error: self class cartIdDoesNotExistErrorMessage! !

!RestInterface methodsFor: 'error signaling' stamp: 'MF 11/4/2021 20:05:57'!
signalUsernameOrPasswordIsInvalid

	^ self error: self class usernameOrPasswordIsInvalidErrorMessage! !


!RestInterface methodsFor: 'accessing' stamp: 'MF 11/9/2021 22:46:37'!
cartWithId: aCartId

	| cartOfCostumer | 
	cartOfCostumer _ currentCarts at: aCartId ifAbsent: [ self signalCartIdIsInvalid ].
	
	(cartOfCostumer stillValidAt: clock now) ifFalse: [ self signalAndDeleteInvalidCart: aCartId ].
	cartOfCostumer touch: clock now.
	
	^cartOfCostumer cart.! !

!RestInterface methodsFor: 'accessing' stamp: 'MF 11/9/2021 22:58:09'!
purchasesOfUserIdentifiedAs: anUserId

	^customerPurchases at: anUserId 
		ifAbsent: [ customerPurchases at: anUserId put: CustomerPurchaseHistory new ].! !

!RestInterface methodsFor: 'accessing' stamp: 'MF 11/9/2021 18:14:17'!
userIdOfCartIdentifiedAs: aCartId

	^(currentCarts at: aCartId ifAbsent: [ self signalCartIdIsInvalid ]) userId.! !


!RestInterface methodsFor: 'queries' stamp: 'MF 11/4/2021 20:41:07'!
listCart: aCartId 

	^(self cartWithId: aCartId) contents.! !

!RestInterface methodsFor: 'queries' stamp: 'MF 11/9/2021 22:57:41'!
listPurchasesOf: anUserId with: aPassword

	self authenticate: anUserId with: aPassword. 
	
	^self purchasesOfUserIdentifiedAs: anUserId.! !


!RestInterface methodsFor: 'cart creation' stamp: 'MF 11/9/2021 22:49:38'!
createCartFor: aUserId with: aPassword 
	
	| cartId |
	self authenticate: aUserId with: aPassword.
	
	currentCarts at: newId 
			     put: (self createCartForCustomerIdentifiedAs: aUserId).
	
	cartId _ self generateNewId.
	^cartId.! !

!RestInterface methodsFor: 'cart creation' stamp: 'MF 11/9/2021 22:51:33'!
createCartForCustomerIdentifiedAs: aUserId

	^ CartOfCustomer for: (Cart acceptingItemsOf: catalog) 
				       atPointInTime: clock now 
				       belongingToUserIdentifiedAs: aUserId! !

!RestInterface methodsFor: 'cart creation' stamp: 'MF 11/9/2021 22:49:02'!
generateNewId

	| currentId |
	currentId _ newId.
	newId _ newId + 1.
	^currentId .! !


!RestInterface methodsFor: 'purchasing' stamp: 'MF 11/10/2021 23:03:14'!
checkOutCart: aCartId with: aCreditCardNumber of: anOwner expiringOn: anExpirationDate   
	
	| cartToCheckout cashier purchasesOfUser |
	cartToCheckout _ self cartWithId: aCartId.
	
	purchasesOfUser _ self purchasesOfUserIdentifiedAs: (self userIdOfCartIdentifiedAs: aCartId).
	
	cashier _ Cashier toCheckout: cartToCheckout  
				charging: (CreditCard expiringOn: anExpirationDate) 
				throught: merchantProcessor
				on: clock now monthOfYear
				registeringOn: purchasesOfUser .
				
	cashier checkOut.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'MF 11/9/2021 16:11:58'!
authenticatingWith: anAuthenticatingSystem withCatalog: aCatalog withMP: aMerchantProcessor withClock: aClock   
	
	^self new initializeAuthenticatingWith: anAuthenticatingSystem withCatalog: aCatalog withMP: aMerchantProcessor withClock: aClock.! !


!RestInterface class methodsFor: 'error messages' stamp: 'MF 11/4/2021 20:45:20'!
cartIdDoesNotExistErrorMessage
	
	^'No cart was found'! !

!RestInterface class methodsFor: 'error messages' stamp: 'MF 11/4/2021 20:04:43'!
usernameOrPasswordIsInvalidErrorMessage
	
	^'Username or password is invalid!!'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'MF 11/9/2021 22:30:07'!
products

	^products.! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MF 11/9/2021 22:27:06'!
initializeTotal: aTotal ofProducts: productsSold 

	total := aTotal. 
	products _ productsSold.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MF 11/9/2021 22:24:50'!
of: aTotal withProducts: productsSold 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ofProducts: productsSold ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MF 11/7/2021 15:19:21'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MF 11/7/2021 15:19:59'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MF 11/7/2021 15:52:53'!
validCCNumber

	^1234567890! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'MF 11/7/2021 15:18:39'!
initialize

	today := FixedGregorianDate today.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'MF 11/7/2021 15:19:37'!
expiredMonthOfYear

	^ (today previous: 1*month) monthOfYear.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'MF 11/7/2021 15:20:11'!
notExpiredMonthOfYear

	^ (today next: 1*month) monthOfYear.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'MF 11/9/2021 16:12:04'!
clock

	^Clock new.! !


!StoreTestObjectsFactory methodsFor: 'user id' stamp: 'MF 11/9/2021 18:04:13'!
anotherValidUserId

	^ 2345! !

!StoreTestObjectsFactory methodsFor: 'user id' stamp: 'MF 11/8/2021 20:16:58'!
validUserId

	^ 1234! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'MF 11/7/2021 16:42:18'!
validMerchantProcessorSimulator

	^MerchantProcessorSimulator withBehaviour:  [ :anAmount :aCreditCard | ].! !
