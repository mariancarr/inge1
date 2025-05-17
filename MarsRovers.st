!classDefinition: #TestsMarsRover category: #MarsRovers!
TestCase subclass: #TestsMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 20:46:07'!
test01
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #N.
	
	self assert:(rover position) equals: 1@1.
	self assert:(rover orientation) equals: #N.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:03:13'!
test02WhenNoCommandToMoveItDoesntMove
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #N.
	rover move: ''.
	self assert:(rover position) equals: 1@1.
	self assert:(rover orientation) equals: #N.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:28:31'!
test03WhenOrderedToMoveForwardOnceAndItIsNorthOrientendItMovesNorthOnePosition
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #N.
	rover move: 'f'.
	self assert:(rover position) equals: 0@1.
	self assert:(rover orientation) equals: #N.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:28:54'!
test04WhenOrderedToMoveForwardNTimesAndItIsNorthOrientendItMovesNorthNTimesPosition
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #N.
	rover move: 'ff'.
	self assert:(rover position) equals: -1@1.
	self assert:(rover orientation) equals: #N.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:30:28'!
test05WhenOrderedToMoveBackwardOnceAndItIsNorthOrientendItMovesToSouthOnePosition
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #N.
	rover move: 'b'.
	self assert:(rover position) equals: 2@1.
	self assert:(rover orientation) equals: #N.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:30:10'!
test06WhenOrderedToMoveBackwardNTimesAndItIsNorthOrientendItMovesToSouthNTimes
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #N.
	rover move: 'bb'.
	self assert:(rover position) equals: 3@1.
	self assert:(rover orientation) equals: #N.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:27:17'!
test07WhenOrderedOnceToMoveForwardAndItIsSouthOrientendItMovesOnceToSouth
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #S.
	rover move: 'f'.
	self assert:(rover position) equals: 3@1.
	self assert:(rover orientation) equals: #S.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:29:58'!
test08WhenOrderedNTimesToMoveForwardAndItIsSouthOrientendItMovesNTimesToSouth
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #S.
	rover move: 'ff'.
	self assert:(rover position) equals: 3@1.
	self assert:(rover orientation) equals: #S.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:32:25'!
test09WhenOrderedToMoveBackwardOnceAndItIsSouthOrientendItMovesToNorthOnce
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #S.
	rover move: 'b'.
	self assert:(rover position) equals: 0@1.
	self assert:(rover orientation) equals: #S.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:34:12'!
test10WhenOrderedToMoveBackwardNTimesAndItIsSouthOrientendItMovesToNorthNTimes
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #S.
	rover move: 'bb'.
	self assert:(rover position) equals: -1@1.
	self assert:(rover orientation) equals: #S.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:42:55'!
test11WhenOrderedOnceToMoveForwardAndItIsEastOrientendItMovesOnceToEast
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #E.
	rover move: 'f'.
	self assert:(rover position) equals: 1@2.
	self assert:(rover orientation) equals: #E.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:44:48'!
test12WhenOrderedOnceToMoveBacwardAndItIsEastOrientendItMovesOnceToWest
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #E.
	rover move: 'b'.
	self assert:(rover position) equals: 1@0.
	self assert:(rover orientation) equals: #E.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:46:41'!
test13WhenOrderedOnceToMoveForwardAndItIsWestOrientendItMovesOnceToWest
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #W.
	rover move: 'f'.
	self assert:(rover position) equals: 1@0.
	self assert:(rover orientation) equals: #W.! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'mc 5/16/2025 21:47:36'!
test14WhenOrderedOnceToMoveBackwardAndItIsWestOrientendItMovesOnceToEast
	|rover|
	rover := MarsRover onPosition: 1@1 withOrientation: #W.
	rover move: 'b'.
	self assert:(rover position) equals: 1@2.
	self assert:(rover orientation) equals: #W.! !


!classDefinition: #MarsRover category: #MarsRovers!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRover methodsFor: 'initialization' stamp: 'mc 5/16/2025 20:32:12'!
initializeOnPosition: aPosition withOrientation: anOrientation 
	
	position := aPosition.
	orientation := anOrientation.! !


!MarsRover methodsFor: 'accesing' stamp: 'mc 5/16/2025 20:32:52'!
orientation
	
	^orientation! !

!MarsRover methodsFor: 'accesing' stamp: 'mc 5/16/2025 20:32:24'!
position
	
	^position! !


!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:13:43'!
move: aSecuenceOfMovements
	
	aSecuenceOfMovements isEmpty 
		ifFalse:[
			aSecuenceOfMovements do:[:movement | 
				movement = $f ifTrue:[
						self moveForward.
						
						].
					
				movement = $b ifTrue:[
						self moveBackwards					
					]	
			].
			
		].! !

!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:48:04'!
moveBackwards

	orientation = #N ifTrue:[self moveOnePositionToSouth].
	orientation = #S ifTrue:[self moveOnePositionToNorth].
	orientation = #E ifTrue:[self moveOnePositionToWest].
	orientation = #W ifTrue:[self moveOnePositionToEast].! !

!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:47:10'!
moveForward

	orientation = #N ifTrue:[self moveOnePositionToNorth].
	orientation = #S ifTrue:[self moveOnePositionToSouth].
	orientation = #E ifTrue:[self moveOnePositionToEast].
	orientation = #W ifTrue:[self moveOnePositionToWest].! !

!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:43:25'!
moveOnePositionToEast
	position:= position x @ (position y +1) ! !

!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:17:43'!
moveOnePositionToNorth

	^ position := (position x) -1 @ position y! !

!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:26:10'!
moveOnePositionToSouth

	^ position := (position x) +1 @ position y! !

!MarsRover methodsFor: 'moving' stamp: 'mc 5/16/2025 21:45:49'!
moveOnePositionToWest
	position := position x @ (position y -1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRovers!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'mc 5/16/2025 20:31:58'!
onPosition: aPosition withOrientation: anOrientation
	
	^self new initializeOnPosition: aPosition withOrientation: anOrientation. ! !
