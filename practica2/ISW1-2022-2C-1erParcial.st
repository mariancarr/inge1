!classDefinition: #CrewTest category: #'ISW1-2022-2C-1erParcial'!
TestCase subclass: #CrewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:37:37'!
test01MovingCrewToTreePlaceDoesNotMove

	| island crew crewPosition treePosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.
			
	crew moveTo: treePosition.
	
	self deny: (island hasCrewAt: treePosition).
	self assert: (island hasCrewAt: crewPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:37:46'!
test02MovingCrewToTreePlaceFilibusteroRemovesTree

	| island crew treePosition crewPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	self deny: (island isEmptyAt: treePosition).
				
	crew moveTo: treePosition.

	self assert: (island isEmptyAt: treePosition).
	
	self deny: (island hasCrewAt: treePosition).
	self assert: (island hasCrewAt: crewPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:37:55'!
test03MovingCrewToFreePlace

	| island crew treePosition crewPosition nextPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	nextPosition := 2@1.
	self assert: (island isEmptyAt: nextPosition).
	
	crew moveTo: nextPosition.

	self deny: (island hasCrewAt: crewPosition).
	self assert: (island hasCrewAt: nextPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:05'!
test04MovingCrewToFreePlaceCorsarioWritesDirectionInMap

	| island crew treePosition crewPosition nextPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	nextPosition := 2@1.
	self assert: map isEmpty.

	crew moveTo: nextPosition.

	self assert: map stepsSize equals: 1. 
	self assert: map lastPosition equals: nextPosition.
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:15'!
test05CrewCannotBuryTreasureIfBucaneroCannotDig

	| island crew treePosition crewPosition map digPosition |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	
	self 
		should: [ crew buryTreasureAt: 3@1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Bucanero cannotDigErrorDescription.
			self deny: map hasTreasureMark ]
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:25'!
test06CrewCanBuryTreasureIfBucaneroCanDig

	| island crew treePosition crewPosition map digPosition |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.
	
	self assert: map hasTreasureMark.
	
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:34'!
test07CaptainCanUseMap

	| island crew treePosition crewPosition map digPosition pirate |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.

	pirate := Bucanero new.
	pirate aCaptainIWasMeantToBe.
	
	self assert: (pirate searchTreasureIn: island with: map)! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:42'!
test08SimplePirateCannotUseMap

	| island crew treePosition crewPosition map digPosition pirate |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.

	pirate := Bucanero new.
	
	self 
		should: [ pirate searchTreasureIn: island with: map ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'I am a simple pirate!!'
! !


!classDefinition: #Crew category: #'ISW1-2022-2C-1erParcial'!
Object subclass: #Crew
	instanceVariableNames: 'island pirates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Crew methodsFor: 'move' stamp: 'mc 5/3/2025 21:27:33'!
move: pirate To: aPosition In: terrain

		
	^pirate moveTo: aPosition In: terrain on: island.
	
		
		
		
		
		

	
	
	! !

!Crew methodsFor: 'move' stamp: 'mc 5/3/2025 23:15:06'!
moveTo: aPosition

	| canMoveToPosition terrain |
	
	terrain := island terrainAt: aPosition.
	
	canMoveToPosition := pirates inject: true into:[:canMove :pirate |
		canMove & (self move: pirate To: aPosition In: terrain). 
	].

	
	canMoveToPosition ifTrue: [ island crewAt: aPosition ].
	
	! !


!Crew methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:44:56'!
buryTreasureAt: aPosition

	| terrain |
	
	terrain := island terrainAt: aPosition.
	
	pirates do: [:pirate | pirate buryTreasureAt: aPosition in: terrain on: island].
	
		
	
		
		! !


!Crew methodsFor: 'initialize' stamp: 'FRT 9/17/2022 22:53:00'!
initializeWith: anIsland pirates: aPirates at: aPosition

	island := anIsland.
	pirates := aPirates.
	
	island crewAt: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Crew class' category: #'ISW1-2022-2C-1erParcial'!
Crew class
	instanceVariableNames: ''!

!Crew class methodsFor: 'as yet unclassified' stamp: 'HAW 9/18/2022 19:21:29'!
at: anIsland composedBy: aCrew at: aPosition

	^ self new initializeWith: anIsland pirates: aCrew at: aPosition ! !


!classDefinition: #Island category: #'ISW1-2022-2C-1erParcial'!
Object subclass: #Island
	instanceVariableNames: 'boardSize treesAt digsAt crewAt treasureAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Island methodsFor: 'as yet unclassified' stamp: 'mc 5/4/2025 00:53:24'!
clearTerrainAt: aPosition

	treesAt remove: aPosition ifAbsent:[]
.	
! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:37:10'!
crewAt: aPosition

	crewAt := aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:45:56'!
hasCrewAt: aPosition

	^ crewAt = aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:23:00'!
initializeSized: size treesAt: treesPositions digsAt: digsPositions

	boardSize := size.
	treesAt := treesPositions.
	digsAt := digsPositions.
! !

!Island methodsFor: 'as yet unclassified' stamp: 'mc 5/4/2025 00:54:46'!
isEmptyAt: aPosition

	
	^(treesAt includes: aPosition) not.
	! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:27:44'!
receiveTreasureAt: aPosition

	treasureAt := aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'mc 5/4/2025 01:09:52'!
terrainAt: aPosition

	^treesAt 
	detect: [:positionTree | positionTree = aPosition]
	ifFound: [:position | ^Tree new ]
	ifNone: [ 
		digsAt 
			detect: [:positionDig | positionDig = aPosition]
			ifFound: [ :position | ^Diggable new ]
			ifNone: [ ^Empty new ] ]

	
	
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Island class' category: #'ISW1-2022-2C-1erParcial'!
Island class
	instanceVariableNames: ''!

!Island class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:46:50'!
sized: size treesAt: treesPositions digsAt: digsPositions

	^ self new initializeSized: size treesAt: treesPositions digsAt: digsPositions 
! !


!classDefinition: #Map category: #'ISW1-2022-2C-1erParcial'!
Object subclass: #Map
	instanceVariableNames: 'island startPosition steps treasureMarkPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Map methodsFor: 'as yet unclassified' stamp: 'mc 5/4/2025 01:14:59'!
hasTreasureMark

	^ treasureMarkPosition notNil.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:30:31'!
initializeWith: anIsland crewStartsAt: aPosition

	island := anIsland.
	startPosition := aPosition.
	steps := OrderedCollection new.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:43:52'!
isEmpty

	^ steps isEmpty
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'mc 5/4/2025 01:12:43'!
lastPosition


	^steps inject: startPosition into:[:lastPosition :step | lastPosition + step ].
	
	
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:39:01'!
nextStep: step

	^ steps add: step.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:32:23'!
stepsSize

	^ steps size.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:01:06'!
treasureMarkAt: aPosition

	treasureMarkPosition := aPosition.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Map class' category: #'ISW1-2022-2C-1erParcial'!
Map class
	instanceVariableNames: ''!

!Map class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:28:38'!
of: island crewStartsAt: aPosition.

	^ self new initializeWith: island crewStartsAt: aPosition.! !


!classDefinition: #Pirate category: #'ISW1-2022-2C-1erParcial'!
Object subclass: #Pirate
	instanceVariableNames: 'rank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Pirate methodsFor: 'move' stamp: 'mc 5/3/2025 21:25:27'!
moveTo: aPosition In: terrain on: island
	self subclassResponsibility .! !


!Pirate methodsFor: 'search' stamp: 'mc 5/4/2025 00:36:10'!
searchTreasureIn: island with: aMap
	
	^rank pirateLookAtMap.! !


!Pirate methodsFor: 'captain' stamp: 'mc 5/4/2025 00:37:58'!
aCaptainIWasMeantToBe
	
	rank:= Captain new.! !


!Pirate methodsFor: 'initialize' stamp: 'mc 5/4/2025 00:41:32'!
initialize

	rank := SimplePirate new! !


!classDefinition: #Bucanero category: #'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Bucanero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!


!Bucanero methodsFor: 'move' stamp: 'mc 5/3/2025 23:06:35'!
moveTo: aPosition In: terrain on: island
	
		^terrain bucanero: self MoveTo: aPosition  on: island 
! !


!Bucanero methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:24:21'!
bucaneroBuryTreasureAtDiggablePosition: aPosition on: island

	island receiveTreasureAt: aPosition.! !

!Bucanero methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:21:51'!
bucaneroBuryTreasureAtInvalidTerrain
	
	self error: self class cannotDigErrorDescription. ! !

!Bucanero methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:22:45'!
buryTreasureAt: aPosition in: terrain on: island

	terrain bucanero: self buryTreasureAt: aPosition  on: island. 

	
		
	! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bucanero class' category: #'ISW1-2022-2C-1erParcial'!
Bucanero class
	instanceVariableNames: ''!

!Bucanero class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 17:12:39'!
cannotDigErrorDescription

	^ 'Arrgh!! I cannot dig this type of terrain!!'.! !


!classDefinition: #Corsario category: #'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Corsario
	instanceVariableNames: 'map'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 22:43:57'!
drawDirectionTo: aPosition

	map nextStep: aPosition - (map lastPosition).
	
! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:01:22'!
drawTreasureMarkAt: aPosition

	map nextStep: aPosition - map lastPosition.
	map treasureMarkAt: aPosition.
	
! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'mc 5/4/2025 00:42:26'!
initializeWith: aMap

	super initialize.
	map := aMap! !


!Corsario methodsFor: 'move' stamp: 'mc 5/3/2025 23:05:12'!
corsarioMoveToEmptyPosition: aPosition on: island

	self drawDirectionTo: aPosition.! !

!Corsario methodsFor: 'move' stamp: 'mc 5/3/2025 23:03:53'!
moveTo: aPosition In: terrain on: island
		
		^terrain corsario: self MoveTo: aPosition on: island.
		
		! !


!Corsario methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:15:55'!
buryTreasureAt: aPosition in: terrain on: island
		
	terrain corsario: self buryTreasureAt: aPosition  on: island. 
	
	! !

!Corsario methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:14:25'!
corsarioBuryTreasureInDiggablePosition: aPosition 

	self drawTreasureMarkAt: aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Corsario class' category: #'ISW1-2022-2C-1erParcial'!
Corsario class
	instanceVariableNames: ''!

!Corsario class methodsFor: 'as yet unclassified' stamp: 'FRT 9/15/2022 21:46:08'!
with: aMap

	^ self new initializeWith: aMap.! !


!classDefinition: #Filibustero category: #'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Filibustero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!


!Filibustero methodsFor: 'move' stamp: 'mc 5/3/2025 23:10:21'!
filibusteroMoveToATreeOnPosition: aPosition on: island

	island clearTerrainAt: aPosition.! !

!Filibustero methodsFor: 'move' stamp: 'mc 5/3/2025 23:11:52'!
moveTo: aPosition In: terrain on: island 
	
		^terrain filibustero: self MoveTo: aPosition on: island.! !


!Filibustero methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:17:08'!
buryTreasureAt: aPosition in: terrain on: island
	
	terrain filibustero: self buryTreasureAt: aPosition  on: island. 
		! !


!classDefinition: #PirateRank category: #'ISW1-2022-2C-1erParcial'!
Object subclass: #PirateRank
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!PirateRank methodsFor: 'searchTreasure' stamp: 'mc 5/4/2025 00:30:40'!
pirateSearchTreasure
	
	self subclassResponsibility ! !


!classDefinition: #Captain category: #'ISW1-2022-2C-1erParcial'!
PirateRank subclass: #Captain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Captain methodsFor: 'searchTreasure' stamp: 'mc 5/4/2025 00:35:17'!
pirateLookAtMap

	^true! !


!classDefinition: #SimplePirate category: #'ISW1-2022-2C-1erParcial'!
PirateRank subclass: #SimplePirate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!SimplePirate methodsFor: 'searchTreasure' stamp: 'mc 5/4/2025 00:35:28'!
pirateLookAtMap

	^self error: self class simplePirateCantLookAtMap. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimplePirate class' category: #'ISW1-2022-2C-1erParcial'!
SimplePirate class
	instanceVariableNames: ''!

!SimplePirate class methodsFor: 'errorMessage' stamp: 'mc 5/4/2025 00:32:30'!
simplePirateCantLookAtMap
 
	^'I am a simple pirate!!'! !


!classDefinition: #Terrain category: #'ISW1-2022-2C-1erParcial'!
Object subclass: #Terrain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Terrain methodsFor: 'move' stamp: 'mc 5/3/2025 21:31:30'!
bucaneroMoveTo: aPosition on: island
	
	self subclassResponsibility ! !

!Terrain methodsFor: 'move' stamp: 'mc 5/3/2025 21:31:35'!
corsarioMoveTo: aPosition on: island
	
	self subclassResponsibility ! !

!Terrain methodsFor: 'move' stamp: 'mc 5/3/2025 21:31:23'!
filibusteroMoveTo: aPosition on: island
	
	self subclassResponsibility ! !


!Terrain methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:25:29'!
bucanero: aBucanero buryTreasureAt: aPosition on: island

	! !

!Terrain methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:25:33'!
corsario: aCorsario buryTreasureAt: aPosition on: island

	! !

!Terrain methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:25:37'!
filibustero: aFilibustero buryTreasureAt: aPosition on: island

	! !


!classDefinition: #Diggable category: #'ISW1-2022-2C-1erParcial'!
Terrain subclass: #Diggable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Diggable methodsFor: 'move' stamp: 'mc 5/3/2025 23:05:58'!
bucanero: aBucanero MoveTo: aPosition on: island

	^true! !

!Diggable methodsFor: 'move' stamp: 'mc 5/3/2025 23:14:12'!
corsario: aCorsario MoveTo: aPosition on: island

	^true! !

!Diggable methodsFor: 'move' stamp: 'mc 5/3/2025 23:11:13'!
filibustero: aFilibustero MoveTo: aPosition on: island

	^true! !


!Diggable methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:23:43'!
bucanero: aBucanero buryTreasureAt: aPosition on: island
	
	aBucanero bucaneroBuryTreasureAtDiggablePosition: aPosition on: island. 
	! !

!Diggable methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:11:47'!
corsario: aCorsario buryTreasureAt: aPosition on: island
	
	aCorsario corsarioBuryTreasureInDiggablePosition: aPosition 
	! !

!Diggable methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:08:11'!
filibustero: aFilibustero buryTreasureAt: aPosition on: island! !


!classDefinition: #Empty category: #'ISW1-2022-2C-1erParcial'!
Terrain subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Empty methodsFor: 'move' stamp: 'mc 5/3/2025 23:05:47'!
bucanero: aBucanero MoveTo: aPosition on: island

	^true! !

!Empty methodsFor: 'move' stamp: 'mc 5/3/2025 23:02:29'!
corsario: aCorsario MoveTo: aPosition on: island
	
		aCorsario corsarioMoveToEmptyPosition: aPosition on: island.			  
		^true 
	! !

!Empty methodsFor: 'move' stamp: 'mc 5/3/2025 23:11:03'!
filibustero: aFilibustero MoveTo: aPosition on: island

	^true! !


!Empty methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:19:51'!
bucanero: aBucanero buryTreasureAt: aPosition on: island

	aBucanero bucaneroBuryTreasureAtInvalidTerrain.! !

!Empty methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:07:58'!
corsario: aCorsario buryTreasureAt: aPosition on: island! !

!Empty methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:08:05'!
filibustero: aFilibustero buryTreasureAt: aPosition on: island! !


!classDefinition: #Tree category: #'ISW1-2022-2C-1erParcial'!
Terrain subclass: #Tree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Tree methodsFor: 'move' stamp: 'mc 5/3/2025 22:58:39'!
bucanero: aBucanero MoveTo: aPosition on: island

		 ^false.! !

!Tree methodsFor: 'move' stamp: 'mc 5/3/2025 22:56:21'!
corsario: aCorsario MoveTo: aPosition on: island

		 ^false.! !

!Tree methodsFor: 'move' stamp: 'mc 5/3/2025 23:10:51'!
filibustero: aFilibustero MoveTo: aPosition on: island
		
		aFilibustero filibusteroMoveToATreeOnPosition: aPosition on: island.
		^ false
		! !


!Tree methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:19:32'!
bucanero: aBucanero buryTreasureAt: aPosition on: island

	aBucanero bucaneroBuryTreasureAtInvalidTerrain.! !

!Tree methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:09:08'!
corsario: aCorsario buryTreasureAt: aPosition on: island
! !

!Tree methodsFor: 'buryTreasure' stamp: 'mc 5/4/2025 00:05:29'!
filibustero: aFilibustero buryTreasureAt: aPosition on: island! !
