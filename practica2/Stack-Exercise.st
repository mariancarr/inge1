!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'state' stamp: 'mc 4/16/2025 11:38:54'!
isEmpty
	^ contents isEmpty.! !

!OOStack methodsFor: 'state' stamp: 'mc 4/16/2025 11:19:39'!
notEmpty
	^contents notEmpty! !

!OOStack methodsFor: 'state' stamp: 'mc 4/16/2025 11:35:51'!
state
	^OOStackState stateFor: self.! !


!OOStack methodsFor: 'initialization' stamp: 'mc 4/16/2025 10:57:11'!
initialize
	contents := OrderedCollection new.! !


!OOStack methodsFor: 'push/pop' stamp: 'mc 4/16/2025 11:34:58'!
pop
	|topElement |
	topElement := self top.
	contents removeLast.
	^topElement .! !

!OOStack methodsFor: 'push/pop' stamp: 'mc 4/16/2025 11:01:07'!
push: anElement
	contents add: anElement.! !

!OOStack methodsFor: 'push/pop' stamp: 'mc 4/16/2025 11:37:07'!
top
	^self state top.! !

!OOStack methodsFor: 'push/pop' stamp: 'mc 4/16/2025 11:30:14'!
topWhenEmpty
	self error: self class stackEmptyErrorDescription .! !

!OOStack methodsFor: 'push/pop' stamp: 'mc 4/16/2025 11:37:29'!
topWhenNotEmpty
	^contents last! !


!OOStack methodsFor: 'size' stamp: 'mc 4/16/2025 11:11:01'!
size
	^contents size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'initialize' stamp: 'mc 4/16/2025 11:27:41'!
initializeFor: aStack
	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'initialization' stamp: 'mc 4/16/2025 11:25:54'!
canHandle: aStack
	^self subclassResponsibility. ! !

!OOStackState class methodsFor: 'initialization' stamp: 'mc 4/16/2025 11:25:38'!
for: aStack.
	^self new initializeFor: aStack.! !

!OOStackState class methodsFor: 'initialization' stamp: 'mc 4/16/2025 11:24:13'!
stateFor: aStack
	^(self subclasses detect: [:aStackState| aStackState canHandle: aStack]) for: aStack.! !


!classDefinition: #OOStackEmpty category: #'Stack-Exercise'!
OOStackState subclass: #OOStackEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmpty methodsFor: 'top' stamp: 'mc 4/16/2025 11:31:57'!
top
	^stack topWhenEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackEmpty class' category: #'Stack-Exercise'!
OOStackEmpty class
	instanceVariableNames: ''!

!OOStackEmpty class methodsFor: 'as yet unclassified' stamp: 'mc 4/16/2025 11:26:38'!
canHandle: aStack
	^aStack isEmpty.! !


!classDefinition: #OOStackNotEmpty category: #'Stack-Exercise'!
OOStackState subclass: #OOStackNotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNotEmpty methodsFor: 'top' stamp: 'mc 4/16/2025 11:32:28'!
top
	^stack topWhenNotEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNotEmpty class' category: #'Stack-Exercise'!
OOStackNotEmpty class
	instanceVariableNames: ''!

!OOStackNotEmpty class methodsFor: 'as yet unclassified' stamp: 'mc 4/16/2025 11:27:01'!
canHandle:aStack
	^aStack notEmpty.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'prefix auxiliarReversedStack stack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'mc 4/16/2025 12:13:04'!
find
	foundSentences:= OrderedCollection new.
	self findSentencesByPrefix.
	self rebuildOriginalStack.
	^foundSentences ! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mc 4/16/2025 12:24:54'!
addToFoundSentenceIfPrefix: aSentence

	^ (aSentence beginsWith: prefix) ifTrue:[foundSentences add: aSentence ]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mc 4/16/2025 13:09:34'!
evaluateSentenceByPrefixOnTopStack

	|sentence|
	sentence := stack pop.
	self addToFoundSentenceIfPrefix: sentence.
	auxiliarReversedStack push: sentence! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mc 4/16/2025 12:22:55'!
findSentencesByPrefix

	^ stack size timesRepeat:[self evaluateSentenceByPrefixOnTopStack.]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mc 4/16/2025 12:27:51'!
pushOriginalElement

	^ stack push: (auxiliarReversedStack pop)! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'mc 4/16/2025 12:27:51'!
rebuildOriginalStack

	auxiliarReversedStack size timesRepeat: [ self pushOriginalElement]! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'mc 4/16/2025 12:02:32'!
initializeWith: aPrefix on: aStack
	prefix := aPrefix.
	stack := aStack.
	auxiliarReversedStack := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'asserts' stamp: 'mc 4/16/2025 11:55:34'!
assertNoSpaces: aPrefix

	(aPrefix includes:$ ) ifTrue: [self error: self errorDescriptionPrefixHasSpaces ].! !

!SentenceFinderByPrefix class methodsFor: 'asserts' stamp: 'mc 4/16/2025 11:45:37'!
assertNotEmpty: aPrefix
	
	^(aPrefix isEmpty) ifTrue: [self error: self errorDescriptionPrefixIsEmpty] ! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'mc 4/16/2025 12:00:52'!
with: aPrefix on: aStack
	self assertNoSpaces: aPrefix.
	self assertNotEmpty: aPrefix.
	^(self new) initializeWith:aPrefix on: aStack ! !


!SentenceFinderByPrefix class methodsFor: 'errorMessages' stamp: 'mc 4/16/2025 11:56:49'!
errorDescriptionPrefixHasSpaces
	^'Prefix can not have spaces' ! !

!SentenceFinderByPrefix class methodsFor: 'errorMessages' stamp: 'mc 4/16/2025 11:57:17'!
errorDescriptionPrefixIsEmpty
	^'Prefix can not be empty' ! !
