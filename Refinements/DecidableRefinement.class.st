Class {
	#name : #DecidableRefinement,
	#superclass : #HPred,
	#instVars : [
		'text'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DecidableRefinement class >> text: t [
	^self basicNew 
		text: t;
		yourself 
]

{ #category : #comparing }
DecidableRefinement >> = another [
	self class = another class ifFalse: [ ^false ].
	^text = another text
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> evaluateIn: aBindEnv [ 
	^aBindEnv evaluate: self text
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> findKVarInGuard: k [ 
	^Either right: self
]

{ #category : #comparing }
DecidableRefinement >> hash [
	^text hash
]

{ #category : #testing }
DecidableRefinement >> isTauto [
	^false
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> kvarsExpr [
	^#()
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> predExpr: kvEnv [
	^self
]

{ #category : #printing }
DecidableRefinement >> printOn: aStream [ 
	aStream
		nextPut: $«;
		nextPutAll: self text;
		nextPut: $»
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> pruneTauts [
	^self
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> rename: a to: b renamer: α [
	^DelayedSubst from: a to: b in: self
]

{ #category : #accessing }
DecidableRefinement >> text [
	^ text
]

{ #category : #accessing }
DecidableRefinement >> text: anObject [
	text := anObject
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> uniq1: α [
	^self
]

{ #category : #'well-formedness' }
DecidableRefinement >> wfIn: gamma [
self shouldBeImplemented "true if self is a bool-(unrefined-)typed formula"
]