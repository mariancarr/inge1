!classDefinition: #AccountSummaryTests category: 'Portfolio'!
TestCase subclass: #AccountSummaryTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:14:23'!
test01AccountWithoutTransactionsOnlyShowsBalanceInAccountSummary
	
	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary of: account.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:13:46'!
test02DepositIsShownInAccountSummary
	
	|account accountSummary|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	accountSummary := AccountSummary of: account.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Depósito por 100' with: 'Balance = 100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:13:39'!
test03WithdrawIsShownInAccountSummary
	
	|account accountSummary|
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	accountSummary := AccountSummary of: account.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Extracción por 100' with: 'Balance = -100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:13:30'!
test04TransferDepositIsShownInAccountSummary
	
	|accountOrigin accountDestination accountSummary|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
	 
	accountSummary := AccountSummary of: accountDestination .
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Entrada por transferencia de 100' with: 'Balance = 100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:13:21'!
test05TransferWithdrawIsShownInAccountSummary
	
	|accountOrigin accountDestination accountSummary|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
	 
	accountSummary := AccountSummary of: accountOrigin.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Salida por transferencia de 100' with: 'Balance = -100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:19:43'!
test06AllTransactionAreShownInAccountSummary
	
	|accountOrigin accountDestination accountSummary|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
	Deposit register: 200 on: accountOrigin.
	Withdraw register: 50 on: accountOrigin.
	 
	accountSummary := AccountSummary of: accountOrigin.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Salida por transferencia de 100' with:'Depósito por 200' with:'Extracción por 50' with: 'Balance = 50')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/5/2025 18:26:46'!
test07PortfolioSummary
	
	|accountOrigin accountDestination accountSummary portfolio|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	
	Transfer register: 100 from: accountOrigin to: accountDestination.
	Deposit register: 200 on: accountOrigin.
	Withdraw register: 50 on: accountDestination .
	
	portfolio := Portfolio with: accountOrigin with: accountDestination.
	 
	accountSummary := AccountSummary of: portfolio.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Salida por transferencia de 100' with:'Depósito por 200' with:'Entrada por transferencia de 100' with:'Extracción por 50' with: 'Balance = 150')! !


!classDefinition: #AccountTransferNetTests category: 'Portfolio'!
TestCase subclass: #AccountTransferNetTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:14:47'!
test01TransferNetIsZeroWhenNoTransfersInAccount

	|account accountTransferNet|
	
	account := ReceptiveAccount new.
	accountTransferNet := AccountTransferNet of: account.
	
	self assert: (accountTransferNet value) equals:0.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:25:22'!
test02TransferDepositIncreaseTransferNet

	|accountOrigin accountDestiny accountTransferNet|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestiny. 
	accountTransferNet := AccountTransferNet of: accountDestiny .
	
	self assert: (accountTransferNet value) equals:100.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:39:41'!
test03TransferWithdrawDecreasesTransferNet

	|accountOrigin accountDestiny accountTransferNet|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestiny. 
	accountTransferNet := AccountTransferNet of: accountOrigin .
	
	self assert: (accountTransferNet value) equals: -100.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:42:44'!
test04DepositDoesntAffectsTransfetNet

	|account  accountTransferNet|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountTransferNet := AccountTransferNet of: account. 
	
	
	self assert: (accountTransferNet value) equals: 0.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:42:38'!
test05WithdrawDoesntAffectsTransfetNet

	|account  accountTransferNet|
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	accountTransferNet := AccountTransferNet of: account. 
	
	
	self assert: (accountTransferNet value) equals: 0.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:54:27'!
test06AllTransactionAffectsAccountTransferNetCorrectly

	|accountOrigin accountDestiny  accountTransferNet|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	
	Transfer register: 40 from: accountOrigin to:accountDestiny.
	Transfer register: 140 from: accountDestiny to: accountOrigin. 
	Deposit register: 100 on: accountOrigin.
	
	accountTransferNet := AccountTransferNet of: accountOrigin . 
	
	
	self assert: (accountTransferNet value) equals: 100.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/5/2025 19:57:10'!
test07PortfolioTransferNet

	|accountOrigin accountDestiny  accountTransferNet portfolio|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	
	Transfer register: 40 from: accountOrigin to:accountDestiny.
	Transfer register: 140 from: accountDestiny to: accountOrigin. 
	portfolio := Portfolio with: accountOrigin with: accountDestiny .
	
	accountTransferNet := AccountTransferNet of: portfolio . 
	
	
	self assert: (accountTransferNet value) equals: 0.! !


!classDefinition: #PortfolioTest category: 'Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferTest category: 'Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 11:37:04'!
test01TransferWithdrawsFromOriginAccountAndDepositInDestinationAccount
	
	| accountOrigin accountDestination |
	
	accountOrigin := ReceptiveAccount  new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
		
	self assert: 100 equals: accountDestination balance .
	self assert: -100 equals: accountOrigin balance .! !

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 11:41:18'!
test02TransferLegsAreRegisteredInCorrespondingAccounts
	
	| accountOrigin accountDestination transfer|
	
	accountOrigin := ReceptiveAccount  new.
	accountDestination := ReceptiveAccount new.
	transfer := Transfer register: 100 from: accountOrigin to: accountDestination.
		
	self assert: (accountOrigin hasRegistered: transfer withdrawLeg).
	self assert: (accountDestination hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 11:54:40'!
test03TransferLegsHaveSameTransfer
	
	|transfer|
	transfer := Transfer for: 100.
		
	self assert: ((transfer withdrawLeg) transfer )equals: transfer.
	self assert: ((transfer depositLeg) transfer) equals: transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 12:55:21'!
test04CanGoFromDepositLegToWithdrawLegOfATransfer
	
	|transfer|
	transfer := Transfer for: 100.
		
	self assert: (transfer depositLeg) withdrawLeg equals: transfer withdrawLeg.! !

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 12:56:38'!
test05CanGoFromWithdrawLegToDepositLegOfATransfer
	
	|transfer|
	transfer := Transfer for: 100.
		
	self assert: (transfer withdrawLeg) depositLeg equals: transfer depositLeg.! !

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 13:16:03'!
test06CantTransferBetweenTheSameAccount
	
	|account|
	
	account := ReceptiveAccount new.
	
	self
	should: [Transfer register: 100 from: account  to: account ]
	raise:  Error
	withExceptionDo: [:anError | 
		self assert:(anError messageText ) equals: Transfer errorMessageCantTransferBetweenSameAccounts	.
	]
	
		
	! !

!TransferTest methodsFor: 'tests' stamp: 'mc 6/5/2025 13:18:45'!
test07CantTransferNegativeValues
	
	|accountOrigin accountDestination|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	
	self
	should: [Transfer register: -100 from: accountOrigin  to: accountDestination ]
	raise:  Error
	withExceptionDo: [:anError | 
		self assert:(anError messageText ) equals: Transfer errorMessageValueMustBePositive.
	]
	
		
	! !


!classDefinition: #Account category: 'Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'summary' stamp: 'mc 6/5/2025 19:35:10'!
visitTransactionsWith: anAccountReport 
	
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'summary' stamp: 'mc 6/5/2025 19:35:02'!
visitTransactionsWith: anAccountReport 
	
	accounts do:[:account | account visitTransactionsWith: anAccountReport ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'summary' stamp: 'mc 6/5/2025 19:34:51'!
visitTransactionsWith: anAccountReport 
	
	transactions do: [:transaction | transaction doWith: anAccountReport].! !


!classDefinition: #AccountReports category: 'Portfolio'!
Object subclass: #AccountReports
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountReports methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:46:48'!
addDeposit: aDeposit

	self subclassResponsibility ! !

!AccountReports methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:47:17'!
addTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!AccountReports methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:47:28'!
addTransferWithdraw: aTransferWithdraw

	self subclassResponsibility ! !

!AccountReports methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:47:03'!
addWithdraw: aWithdraw

	self subclassResponsibility ! !


!AccountReports methodsFor: 'initialization' stamp: 'mc 6/5/2025 19:48:06'!
initializeOf: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReports class' category: 'Portfolio'!
AccountReports class
	instanceVariableNames: ''!

!AccountReports class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 19:45:21'!
of: anAccount

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio'!
AccountReports subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!AccountSummary methodsFor: 'summary' stamp: 'mc 6/5/2025 17:22:32'!
summary
	
	summary := OrderedCollection new.
	
	account visitTransactionsWith: self.
	summary add: 'Balance = ', (account balance) asString.
	
	^summary! !


!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/5/2025 18:09:15'!
addDeposit: aDeposit 
	
	summary add: 'Depósito por ', (aDeposit value) asString! !

!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/5/2025 18:04:34'!
addTransferDeposit: aTransferDeposit
	
	summary add: 'Entrada por transferencia de ', (aTransferDeposit value) asString.! !

!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/5/2025 18:08:16'!
addTransferWithdraw: aTransferWithdraw
	
	summary add: 'Salida por transferencia de ', (aTransferWithdraw value) asString.! !

!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/5/2025 18:01:32'!
addWithdraw: aWithdraw 
	
	summary add: 'Extracción por ', (aWithdraw value) asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 17:00:09'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #AccountTransferNet category: 'Portfolio'!
AccountReports subclass: #AccountTransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:42:05'!
addDeposit: aDeposit 
	! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:39:02'!
addTransferDeposit: aTransferDeposit

	transferNet  := transferNet + (aTransferDeposit value)! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:40:13'!
addTransferWithdraw: aTransferWithdraw

	transferNet := transferNet - (aTransferWithdraw value)! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:43:03'!
addWithdraw: aWithdraw 
	! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/5/2025 19:30:12'!
value
	
	transferNet := 0.
	account visitTransactionsWith: self.
	
	^transferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: 'Portfolio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 19:19:19'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'summary' stamp: 'mc 6/5/2025 19:37:33'!
doWith: anAccountReport 
	
	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'summary' stamp: 'mc 6/5/2025 19:37:40'!
doWith: anAccountReport 
	
	anAccountReport addDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferLeg methodsFor: 'balance' stamp: 'mc 6/5/2025 12:17:33'!
affectBalance: aBalance 
	
	self subclassResponsibility. ! !


!TransferLeg methodsFor: 'accesing' stamp: 'mc 6/5/2025 12:18:04'!
transfer
	
	^transfer! !

!TransferLeg methodsFor: 'accesing' stamp: 'mc 6/5/2025 18:05:48'!
value
	
	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'mc 6/5/2025 12:20:04'!
initializeWithTransfer: aTransfer 
	
	transfer := aTransfer.! !


!TransferLeg methodsFor: 'summary' stamp: 'mc 6/5/2025 19:37:51'!
doWith: anAccountReport 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio'!
TransferLeg class
	instanceVariableNames: 'transfer'!

!TransferLeg class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 12:19:41'!
asLegOf: aTransfer 
	
	^self new initializeWithTransfer: aTransfer.! !


!classDefinition: #TransferDepositLeg category: 'Portfolio'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferDepositLeg methodsFor: 'balance' stamp: 'mc 6/5/2025 12:18:33'!
affectBalance: aBalance
	
	^(transfer value) + aBalance ! !


!TransferDepositLeg methodsFor: 'accesing' stamp: 'mc 6/5/2025 12:55:59'!
withdrawLeg
	
	^transfer withdrawLeg ! !


!TransferDepositLeg methodsFor: 'summary' stamp: 'mc 6/5/2025 19:36:01'!
doWith: anAccountReport 
	
	anAccountReport addTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDepositLeg class' category: 'Portfolio'!
TransferDepositLeg class
	instanceVariableNames: ''!

!TransferDepositLeg class methodsFor: 'balance' stamp: 'mc 6/5/2025 12:15:50'!
affectBalance: aBalance 
	
	^transfer value! !


!classDefinition: #TransferWithdrawLeg category: 'Portfolio'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'mc 6/5/2025 12:18:59'!
affectBalance: aBalance 
	
	^aBalance - (transfer value)! !


!TransferWithdrawLeg methodsFor: 'accesing' stamp: 'mc 6/5/2025 12:56:54'!
depositLeg
	
	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'summary' stamp: 'mc 6/5/2025 19:38:00'!
doWith: anAccountReport 
	
	anAccountReport addTransferWithdraw: self! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'summary' stamp: 'mc 6/5/2025 19:38:07'!
doWith: anAccountReport 
	
	anAccountReport addWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'initialization' stamp: 'mc 6/5/2025 12:10:23'!
initializeFor: aValue 
	
	value := aValue.
	withdrawLeg := TransferWithdrawLeg asLegOf: self.
	depositLeg := TransferDepositLeg asLegOf: self.! !


!Transfer methodsFor: 'accesing' stamp: 'mc 6/5/2025 11:46:41'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'accesing' stamp: 'mc 6/5/2025 12:21:10'!
value

	^value! !

!Transfer methodsFor: 'accesing' stamp: 'mc 6/5/2025 11:46:28'!
withdrawLeg
	
	^withdrawLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 13:14:06'!
assertAccount: accountDestination isDifferentFromAccount: accountOrigin

	^ accountOrigin = accountDestination ifTrue:[self errorCantTransferBetweenAccounts]! !

!Transfer class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 13:21:21'!
assertValueIsPositive: aValue

	^ aValue strictlyPositive ifFalse:[self errorValueMustBePositive]! !

!Transfer class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 13:15:44'!
errorCantTransferBetweenAccounts

	self error: self errorMessageCantTransferBetweenSameAccounts	! !

!Transfer class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 13:21:21'!
errorValueMustBePositive

	^ self error: self errorMessageValueMustBePositive! !

!Transfer class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 11:55:18'!
for: aValue
	
	^self new initializeFor: aValue ! !

!Transfer class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 13:20:13'!
register: aValue from: accountOrigin to: accountDestination 
	
	|transfer|	
	
	self assertAccount: accountDestination isDifferentFromAccount: accountOrigin.
	self assertValueIsPositive: aValue.
	
	transfer := Transfer for: aValue.
	
	accountOrigin register: transfer withdrawLeg. 
	accountDestination register: transfer depositLeg.
	
	^transfer! !


!Transfer class methodsFor: 'error' stamp: 'mc 6/5/2025 13:15:12'!
errorMessageCantTransferBetweenSameAccounts
	
	^'Cant transfer between the same account'! !

!Transfer class methodsFor: 'error' stamp: 'mc 6/5/2025 13:22:05'!
errorMessageValueMustBePositive
	
	^'value must be positive'! !
