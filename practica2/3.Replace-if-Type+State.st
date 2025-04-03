!classDefinition: #PowerStatus category: #'3.Replace-if-Type+State'!
Object subclass: #PowerStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!


!classDefinition: #PowerOff category: #'3.Replace-if-Type+State'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOff methodsFor: 'move'!
! !


!classDefinition: #PowerOn category: #'3.Replace-if-Type+State'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOn methodsFor: 'move'!
! !


!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization'!
! !


!Vehicle methodsFor: 'move'!
! !


!Vehicle methodsFor: 'on/off'!
! !

!Vehicle methodsFor: 'on/off'!
! !


!Vehicle methodsFor: 'error messages'!
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation'!
! !

!Vehicle class methodsFor: 'instance creation'!
! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'errorMessage'!
! !


!Helicopter methodsFor: 'move'!
! !

!Helicopter methodsFor: 'move'!
! !

!Helicopter methodsFor: 'move'!
! !


!Helicopter methodsFor: 'inicializar'!
! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motorcycle methodsFor: 'move'!
! !

!Motorcycle methodsFor: 'move'!
! !

!Motorcycle methodsFor: 'move'!
! !


!Motorcycle methodsFor: 'errorMessage'!
! !
