!classDefinition: #Account category: #Portfolio!
Object subclass: #Account
	instanceVariableNames: 'name'
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


!Account methodsFor: 'accesing' stamp: 'mc 6/8/2025 12:23:33'!
doWith: anAccountVisitor
	
	self subclassResponsibility ! !

!Account methodsFor: 'accesing' stamp: 'mc 6/7/2025 12:27:22'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #Portfolio!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'mc 6/7/2025 12:15:33'!
named: aName
	
	^self new initializeNamed: aName ! !


!classDefinition: #Portfolio category: #Portfolio!
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


!Portfolio methodsFor: 'initialization' stamp: 'mc 6/7/2025 12:06:39'!
initializeNamed: aName 
	
	name := aName.
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


!Portfolio methodsFor: 'summary' stamp: 'mc 6/8/2025 12:39:12'!
visitTransactionsWith: anAccountReport 
	
	accounts do:[:account | account visitTransactionsWith: anAccountReport ].! !


!Portfolio methodsFor: 'accesing' stamp: 'mc 6/8/2025 12:23:54'!
doWith: anAccountVisitor 
	
	anAccountVisitor doWithPortfolio: self.! !

!Portfolio methodsFor: 'accesing' stamp: 'mc 6/7/2025 12:44:37'!
visitAccountsWith: aPortfolioTreePrinter 
	
	accounts do:[:account | account doWith: aPortfolioTreePrinter].! !


!Portfolio methodsFor: '[mk] initialization' stamp: 'mc 6/8/2025 12:34:39'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #Portfolio!
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


!classDefinition: #ReceptiveAccount category: #Portfolio!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'mc 6/7/2025 12:16:40'!
initializeNamed: aName 
	
	name := aName.
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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mc 6/8/2025 12:24:04'!
doWith: aAccountVisitor 
	
	aAccountVisitor doWithReceptiveAccount: self.! !


!ReceptiveAccount methodsFor: '[mk] initialization' stamp: 'mc 6/8/2025 12:31:58'!
initialize
	
	transactions := OrderedCollection new.! !


!classDefinition: #AccountTransaction category: #Portfolio!
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

!classDefinition: 'AccountTransaction class' category: #Portfolio!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #Portfolio!
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


!Deposit methodsFor: 'summary' stamp: 'mc 6/7/2025 11:52:53'!
doWith: anAccountReport 
	
	anAccountReport doWithDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #Portfolio!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #Portfolio!
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

!classDefinition: 'TransferLeg class' category: #Portfolio!
TransferLeg class
	instanceVariableNames: 'transfer'!

!TransferLeg class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 12:19:41'!
asLegOf: aTransfer 
	
	^self new initializeWithTransfer: aTransfer.! !


!classDefinition: #TransferDepositLeg category: #Portfolio!
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


!TransferDepositLeg methodsFor: 'summary' stamp: 'mc 6/7/2025 11:52:35'!
doWith: anAccountReport 
	
	anAccountReport doWithTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDepositLeg class' category: #Portfolio!
TransferDepositLeg class
	instanceVariableNames: ''!

!TransferDepositLeg class methodsFor: 'balance' stamp: 'mc 6/5/2025 12:15:50'!
affectBalance: aBalance 
	
	^transfer value! !


!classDefinition: #TransferWithdrawLeg category: #Portfolio!
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


!TransferWithdrawLeg methodsFor: 'summary' stamp: 'mc 6/7/2025 11:52:44'!
doWith: anAccountReport 
	
	anAccountReport doWithTransferWithdraw: self! !


!classDefinition: #Withdraw category: #Portfolio!
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


!Withdraw methodsFor: 'summary' stamp: 'mc 6/7/2025 11:52:59'!
doWith: anAccountReport 
	
	anAccountReport doWithWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #Portfolio!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountVisitor category: #Portfolio!
Object subclass: #AccountVisitor
	instanceVariableNames: 'portfolio spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountVisitor methodsFor: 'summary' stamp: 'mc 6/8/2025 12:28:31'!
doWithPortfolio: aPortfolio

	self subclassResponsibility! !

!AccountVisitor methodsFor: 'summary' stamp: 'mc 6/8/2025 12:28:15'!
doWithReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !


!AccountVisitor methodsFor: 'initialization' stamp: 'mc 6/8/2025 12:29:06'!
initializeOf: aPortfolio 
	
	portfolio := aPortfolio.! !


!classDefinition: #PortfolioSummary category: #Portfolio!
AccountVisitor subclass: #PortfolioSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!PortfolioSummary methodsFor: 'summary' stamp: 'mc 6/8/2025 12:17:50'!
addAccountNameOf: anAccount

	^ self addToSummary: anAccount! !

!PortfolioSummary methodsFor: 'summary' stamp: 'mc 6/8/2025 12:16:07'!
addToSummary: aNameAccount

	^ summary add: spaces,aNameAccount name! !

!PortfolioSummary methodsFor: 'summary' stamp: 'mc 6/8/2025 12:19:04'!
doWithPortfolio: aPortfolio 
	
	self addAccountNameOf: aPortfolio.
	
	spaces := spaces,'  '.
	
	aPortfolio visitAccountsWith: self.
	
	summary add: spaces, 'Balance = ', (aPortfolio balance) asString.
	
	spaces := spaces allButLast: 2.
	
	! !

!PortfolioSummary methodsFor: 'summary' stamp: 'mc 6/8/2025 12:18:48'!
doWithReceptiveAccount: aReceptiveAccount 
	
	| accountSummary |
	
	self addAccountNameOf: aReceptiveAccount.
	
	spaces := spaces,'  '.
	
	accountSummary := (AccountSummary of: aReceptiveAccount) summary.
	accountSummary do: [:aTransactionSummary | summary add: (spaces,aTransactionSummary)]. 
	
	spaces := spaces allButLast: 2.! !

!PortfolioSummary methodsFor: 'summary' stamp: 'mc 6/8/2025 12:10:06'!
summary
	
	summary := OrderedCollection new.
	spaces := ''.
	
	self doWithPortfolio: portfolio.
	
	
	^summary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSummary class' category: #Portfolio!
PortfolioSummary class
	instanceVariableNames: ''!

!PortfolioSummary class methodsFor: 'instance creation' stamp: 'mc 6/7/2025 18:24:40'!
of: aPortfolio 
	
	^self new initializeOf: aPortfolio ! !


!classDefinition: #PortfolioTreePrinter category: #Portfolio!
AccountVisitor subclass: #PortfolioTreePrinter
	instanceVariableNames: 'tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTreePrinter methodsFor: 'treePrint' stamp: 'mc 6/7/2025 12:32:06'!
accountsEmpty: aPortfolio 
	
	tree add: portfolio name.! !

!PortfolioTreePrinter methodsFor: 'treePrint' stamp: 'mc 6/7/2025 12:28:31'!
accountsNotEmpty: anAccount


	tree add: portfolio name; add: '  ', anAccount name .! !

!PortfolioTreePrinter methodsFor: 'treePrint' stamp: 'mc 6/7/2025 12:50:00'!
addName: aName

	tree add: (spaces, aName).
	! !

!PortfolioTreePrinter methodsFor: 'treePrint' stamp: 'mc 6/7/2025 13:32:58'!
doWithPortfolio: aPortfolio 
	
	
	self addName: aPortfolio name.
	spaces := spaces, '  '.
	aPortfolio visitAccountsWith: self.
	spaces := spaces allButLast: 2.! !

!PortfolioTreePrinter methodsFor: 'treePrint' stamp: 'mc 6/7/2025 12:49:05'!
doWithReceptiveAccount: aReceptiveAccount 
	
	self addName: aReceptiveAccount name.! !

!PortfolioTreePrinter methodsFor: 'treePrint' stamp: 'mc 6/7/2025 13:32:46'!
print
	
	tree := OrderedCollection new.
	
	spaces := ''.
	self addName: portfolio name.
	
	spaces := spaces, '  '.
	portfolio visitAccountsWith: self.
	
	^tree.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #Portfolio!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'mc 6/7/2025 12:06:58'!
of: aPortfolio 
	
	^self new initializeOf: aPortfolio ! !


!classDefinition: #TransactionVisitor category: #Portfolio!
Object subclass: #TransactionVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransactionVisitor methodsFor: 'operation' stamp: 'mc 6/7/2025 11:30:04'!
result
	
	self subclassResponsibility ! !


!TransactionVisitor methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:51:55'!
doWithDeposit: aDeposit

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:04'!
doWithTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:12'!
doWithTransferWithdraw: aTransferWithdraw

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:22'!
doWithWithdraw: aWithdraw

	self subclassResponsibility ! !


!TransactionVisitor methodsFor: 'initialization' stamp: 'mc 6/5/2025 19:48:06'!
initializeOf: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionVisitor class' category: #Portfolio!
TransactionVisitor class
	instanceVariableNames: ''!

!TransactionVisitor class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 19:45:21'!
of: anAccount

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: #Portfolio!
TransactionVisitor subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummary methodsFor: 'summary' stamp: 'mc 6/7/2025 11:59:12'!
summary
	
	summary := OrderedCollection new.
	
	account visitTransactionsWith: self.
	summary add: 'Balance = ', (account balance) asString.
	
	^summary! !


!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:51:55'!
doWithDeposit: aDeposit 
	
	summary add: 'Depósito por ', (aDeposit value) asString! !

!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:05'!
doWithTransferDeposit: aTransferDeposit
	
	summary add: 'Entrada por transferencia de ', (aTransferDeposit value) asString.! !

!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:12'!
doWithTransferWithdraw: aTransferWithdraw
	
	summary add: 'Salida por transferencia de ', (aTransferWithdraw value) asString.! !

!AccountSummary methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:22'!
doWithWithdraw: aWithdraw 
	
	summary add: 'Extracción por ', (aWithdraw value) asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #Portfolio!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 17:00:09'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #AccountTransferNet category: #Portfolio!
TransactionVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:51:56'!
doWithDeposit: aDeposit 
	! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:53:45'!
doWithTransferDeposit: aTransferDeposit

	transferNet  := transferNet + (aTransferDeposit value)! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:53:29'!
doWithTransferWithdraw: aTransferWithdraw

	transferNet := transferNet - (aTransferWithdraw value)! !

!AccountTransferNet methodsFor: 'transaction do' stamp: 'mc 6/7/2025 11:52:22'!
doWithWithdraw: aWithdraw 
	! !


!AccountTransferNet methodsFor: 'operation' stamp: 'mc 6/7/2025 11:59:02'!
value
	
	transferNet := 0.
	account visitTransactionsWith: self.
	
	^transferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #Portfolio!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'mc 6/5/2025 19:19:19'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #Transfer category: #Portfolio!
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

!classDefinition: 'Transfer class' category: #Portfolio!
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


!classDefinition: #AccountSummaryTests category: #Portfolio!
TestCase subclass: #AccountSummaryTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:01'!
test01AccountWithoutTransactionsOnlyShowsBalanceInAccountSummary
	
	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary of: account.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:05'!
test02DepositIsShownInAccountSummary
	
	|account accountSummary|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	accountSummary := AccountSummary of: account.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Depósito por 100' with: 'Balance = 100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:07'!
test03WithdrawIsShownInAccountSummary
	
	|account accountSummary|
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	accountSummary := AccountSummary of: account.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Extracción por 100' with: 'Balance = -100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:10'!
test04TransferDepositIsShownInAccountSummary
	
	|accountOrigin accountDestination accountSummary|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
	 
	accountSummary := AccountSummary of: accountDestination .
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Entrada por transferencia de 100' with: 'Balance = 100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:12'!
test05TransferWithdrawIsShownInAccountSummary
	
	|accountOrigin accountDestination accountSummary|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
	 
	accountSummary := AccountSummary of: accountOrigin.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Salida por transferencia de 100' with: 'Balance = -100')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:14'!
test06AllTransactionAreShownInAccountSummary
	
	|accountOrigin accountDestination accountSummary|
	
	accountOrigin := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestination.
	Deposit register: 200 on: accountOrigin.
	Withdraw register: 50 on: accountOrigin.
	 
	accountSummary := AccountSummary of: accountOrigin.
	
	self assert: accountSummary summary  equals: (OrderedCollection with: 'Salida por transferencia de 100' with:'Depósito por 200' with:'Extracción por 50' with: 'Balance = 50')! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'mc 6/7/2025 12:00:16'!
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


!classDefinition: #AccountTransferNetTests category: #Portfolio!
TestCase subclass: #AccountTransferNetTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:42'!
test01TransferNetIsZeroWhenNoTransfersInAccount

	|account accountTransferNet|
	
	account := ReceptiveAccount new.
	accountTransferNet := AccountTransferNet of: account.
	
	self assert: (accountTransferNet value) equals:0.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:39'!
test02TransferDepositIncreaseTransferNet

	|accountOrigin accountDestiny accountTransferNet|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestiny. 
	accountTransferNet := AccountTransferNet of: accountDestiny .
	
	self assert: (accountTransferNet value) equals:100.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:35'!
test03TransferWithdrawDecreasesTransferNet

	|accountOrigin accountDestiny accountTransferNet|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	Transfer register: 100 from: accountOrigin to: accountDestiny. 
	accountTransferNet := AccountTransferNet of: accountOrigin .
	
	self assert: (accountTransferNet value) equals: -100.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:33'!
test04DepositDoesntAffectsTransfetNet

	|account  accountTransferNet|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountTransferNet := AccountTransferNet of: account. 
	
	
	self assert: (accountTransferNet value) equals: 0.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:31'!
test05WithdrawDoesntAffectsTransfetNet

	|account  accountTransferNet|
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	accountTransferNet := AccountTransferNet of: account. 
	
	
	self assert: (accountTransferNet value) equals: 0.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:28'!
test06AllTransactionAffectsAccountTransferNetCorrectly

	|accountOrigin accountDestiny  accountTransferNet|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	
	Transfer register: 40 from: accountOrigin to:accountDestiny.
	Transfer register: 140 from: accountDestiny to: accountOrigin. 
	Deposit register: 100 on: accountOrigin.
	
	accountTransferNet := AccountTransferNet of: accountOrigin . 
	
	
	self assert: (accountTransferNet value) equals: 100.! !

!AccountTransferNetTests methodsFor: 'tests' stamp: 'mc 6/7/2025 11:59:25'!
test07PortfolioTransferNet

	|accountOrigin accountDestiny  accountTransferNet portfolio|
	
	accountOrigin := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	
	Transfer register: 40 from: accountOrigin to:accountDestiny.
	Transfer register: 140 from: accountDestiny to: accountOrigin. 
	portfolio := Portfolio with: accountOrigin with: accountDestiny .
	
	accountTransferNet := AccountTransferNet of: portfolio . 
	
	
	self assert: (accountTransferNet value) equals: 0.! !


!classDefinition: #PortfolioSummaryTest category: #Portfolio!
TestCase subclass: #PortfolioSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'mc 6/8/2025 12:05:18'!
test01PortfolioEmptyOnlyShowsHisNameAndBalance

	|portfolio portfolioSummary portfolioName |
	
	portfolioName := 'Portfolio vacio'.
	portfolio := Portfolio named: portfolioName.
	
	portfolioSummary := PortfolioSummary of: portfolio.
	
	self assert: (portfolioSummary summary) equals: (OrderedCollection with: portfolioName with: '  Balance = ', (portfolio balance) asString).! !

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'mc 6/8/2025 12:04:36'!
test02PortfolioWithAccountShowsTheirTransactionsAndNames

	|accountNameChild accountChild accountNameParent accountParent portfolioParent portfolioChild portfolioSummary portfolioParentName portfolioChildName expectedSummary|
	

	accountNameChild := 'Cuenta de Jose'.
	accountChild := ReceptiveAccount named: accountNameChild .
	
	
	portfolioChildName := 'Portfolio de hijo'.
	portfolioChild := Portfolio named: portfolioChildName .
	portfolioChild add: accountChild.
	
	accountNameParent := 'Cuenta de Mariano'.
	accountParent := ReceptiveAccount named: accountNameParent .
	Transfer register: 50 from: accountParent to: accountChild.
	Deposit register:100 on: accountParent.
	Withdraw  register: 100 on: accountParent.
	
	portfolioParentName := 'Portfolio de Padre'.
	portfolioParent := Portfolio named: portfolioParentName.
	portfolioParent add: accountParent; add: portfolioChild. 
	
	portfolioSummary := PortfolioSummary of: portfolioParent.
	
	expectedSummary := {	portfolioParentName.
							'  ',accountNameParent.
							'    Salida por transferencia de 50'.
							'    Depósito por 100'.
							'    Extracción por 100'.
							'    Balance = ', (accountParent balance) asString.
							'  ', portfolioChildName.
							'    ', accountNameChild.
							'      Entrada por transferencia de 50'	.
							'      Balance = ', (accountChild balance) asString.
							'    Balance = ', (portfolioChild balance) asString.
							'  Balance = ', (portfolioParent balance) asString.
						}.
	self assert: (portfolioSummary summary) 
	equals: expectedSummary asOrderedCollection .! !


!classDefinition: #PortfolioTest category: #Portfolio!
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


!classDefinition: #PortfolioTreePrinterTest category: #Portfolio!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'mc 6/7/2025 12:09:01'!
test01EmptyPortolioOnlyPrintsItself

	|portfolio portfolioName portfolioTreePrinter|
	
	portfolioName := 'Portfolio de Mariano'.
	portfolio := Portfolio named: portfolioName .
	
	portfolioTreePrinter := PortfolioTreePrinter of: portfolio.
	
	self assert: (portfolioTreePrinter print) equals: (OrderedCollection with: portfolioName )! !

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'mc 6/7/2025 12:30:11'!
test02PortfolioWithAccountShowsAccountIdented

	|accountJulieta portfolioMariano accountName portfolioName portfolioTreePrinter|
	
	accountName := 'Cuenta de Julieta'.
	portfolioName := 'Portfolio de Mariano'.
	
	accountJulieta := ReceptiveAccount named: accountName.
	
	portfolioMariano := Portfolio named: portfolioName .
	portfolioMariano add: accountJulieta. 
	
	
	portfolioTreePrinter := PortfolioTreePrinter of: portfolioMariano .
	
	self assert: (portfolioTreePrinter print) equals: (OrderedCollection with: portfolioName with: '  ',accountName  )! !

!PortfolioTreePrinterTest methodsFor: 'test' stamp: 'mc 6/7/2025 13:03:57'!
test03PortfolioWithAccountAndPortfoliosPrintThemAllCorrectlyIdented

	|accountJulieta portfolioHijo accountHijo accountHijoName accountJulietaName portfolioPadreName portfolioHijoName portfolioPadre portfolioTreePrinter|
	
	accountJulietaName := 'Cuenta de Julieta'.
	accountHijoName := 'Cuenta del Hijo'.
	portfolioPadreName := 'Portfolio Padre'.  
	portfolioHijoName := 'Portfolio hijo'.
	
	accountHijo := ReceptiveAccount named: accountHijoName. 
	portfolioHijo := Portfolio named: portfolioHijoName .
	portfolioHijo add: accountHijo.
	
	accountJulieta := ReceptiveAccount named: accountJulietaName.
	portfolioPadre := Portfolio named: portfolioPadreName .  
	portfolioPadre add: portfolioHijo; add: accountJulieta.
	
	portfolioTreePrinter := PortfolioTreePrinter of: portfolioPadre.
	
	self assert: (portfolioTreePrinter print) 
	equals: (OrderedCollection 
				with: portfolioPadreName
				with: '  ', portfolioHijoName
				with: '    ', accountHijoName
				with: '  ', accountJulietaName 	
			)
	! !


!classDefinition: #ReceptiveAccountTest category: #Portfolio!
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


!classDefinition: #TransferTest category: #Portfolio!
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
