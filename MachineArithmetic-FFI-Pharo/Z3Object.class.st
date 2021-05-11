Class {
	#name : #Z3Object,
	#superclass : #FFIExternalObject,
	#classVars : [
		'EmptyExternalArray'
	],
	#classInstVars : [
		'instances'
	],
	#category : #'MachineArithmetic-FFI-Pharo'
}

{ #category : #'as yet unclassified' }
Z3Object class >> asExternalTypeOn: generator [
	^ Z3ObjectType objectClass: self
]

{ #category : #utilities }
Z3Object class >> externalArrayFrom: anArray [
	"Given (smalltalk) `anArray` of Z3 objects, create external (C) array
	 with corresponding (C) pointers to libz3 objects."

	| extArray |
	
	anArray isEmpty ifTrue:[ ^ EmptyExternalArray ].
	
	extArray := FFIExternalArray externalNewType: 'void*' size: anArray size.
	anArray withIndexDo:[:o :i |
		extArray at: i put: (o isNil ifTrue:[ExternalAddress null] ifFalse:[o getHandle getHandle])
	].
	^extArray
		
]

{ #category : #initialization }
Z3Object class >> initialize [
	EmptyExternalArray := FFIExternalArray externalNewType: 'void*' size: 0.
	
	"
	Z3Object initialize
	"
]

{ #category : #'as yet unclassified' }
Z3Object class >> instances [
	instances isNil ifTrue: [ instances := WeakValueDictionary new ].
	^instances 
]

{ #category : #'as yet unclassified' }
Z3Object class >> new: anExternalData [ 
	| instance |
	instance := 	self basicNew.
	self instances at: anExternalData asInteger put: instance.
	^instance handle: anExternalData; yourself
]

{ #category : #'as yet unclassified' }
Z3Object class >> unwrapAround: anObject [
	self instances removeKey: anObject handle asInteger.	
	
]

{ #category : #'as yet unclassified' }
Z3Object class >> wrapAround: anExternalData [ 
	^self instances
		at: anExternalData asInteger
		ifAbsent: [ self new: anExternalData ]
]

{ #category : #utilities }
Z3Object >> externalArray: anFFIExternalArray  pointerAt: anInteger [
	^ anFFIExternalArray at: anInteger 
		
]

{ #category : #utilities }
Z3Object >> externalArrayFrom: anArray [
	^self class externalArrayFrom: anArray 
		
]

{ #category : #utilities }
Z3Object >> poison [
	"'Poison' the object, i.e., set the handle to 'poison' value. 
	 To be called when the object is destroyed in Smalltalk and should
	 no longer be used. This is to help debugging use-after-free bugs."
	
	self setHandle: ExternalAddress newPoison 
]