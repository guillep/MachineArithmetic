Extension { #name : #Object }

{ #category : #'*PreSmalltalks' }
Object >> K [
	^[ :y | self ]
]

{ #category : #'*PreSmalltalks' }
Object >> at: index nonDestructivePut: value [
	^self copy
		at: index put: value;
		yourself
]

{ #category : #'*PreSmalltalks' }
Object >> maybeToList [
	^{self}
]

{ #category : #'*PreSmalltalks' }
Object >> printStructOn: aStream [
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' ('.	
	self class instVarNames do: [ :iv |
		(self instVarNamed: iv) printOn: aStream
 ] separatedBy: [ 	aStream nextPutAll: ') (' ].
	aStream nextPutAll: ')'
]
