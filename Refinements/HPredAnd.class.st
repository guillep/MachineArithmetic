Class {
	#name : #HPredAnd,
	#superclass : #HPred,
	#instVars : [
		'conjuncts'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HPredAnd class >> of: conjuncts [
	^self basicNew
		conjuncts: conjuncts;
		yourself
]

{ #category : #comparing }
HPredAnd >> = another [
	self class = another class ifFalse: [ ^false ].
	^conjuncts = another conjuncts
]

{ #category : #GT }
HPredAnd >> children [
	^conjuncts
]

{ #category : #accessing }
HPredAnd >> conjuncts [
	^ conjuncts
]

{ #category : #accessing }
HPredAnd >> conjuncts: aCollection [ 
	conjuncts := aCollection
]

{ #category : #logic }
HPredAnd >> findKVarInGuard: k [ 
	self shouldBeImplemented.
]

{ #category : #logic }
HPredAnd >> flatConstraint [
	| flatConjuncts |
	flatConjuncts := self conjuncts flatConstraint.
	"special-case of singleton collection"
	flatConjuncts size = 1 ifTrue: [ ^flatConjuncts anyOne ].
	^HPredAnd of: flatConjuncts
]

{ #category : #comparing }
HPredAnd >> hash [
	^conjuncts size hash
]

{ #category : #'as yet unclassified' }
HPredAnd >> isTauto [
	conjuncts do: [ :c | c isTauto ifFalse: [ ^false ]].
	^true
]

{ #category : #logic }
HPredAnd >> pKVars [ 
	| answer |
	answer := Set new.
	(self conjuncts collect: [ :child | child pKVars ]) do: [ :aSet | answer addAll: aSet ].
	^answer
]

{ #category : #'as yet unclassified' }
HPredAnd >> predExpr: kvEnv [
	^HPredAnd of: (self conjuncts collect: [ :c | c predExpr: kvEnv ])
]

{ #category : #printing }
HPredAnd >> printOn: aStream [
	aStream nextPut: $&.
	self conjuncts printElementsOn: aStream 
]

{ #category : #'as yet unclassified' }
HPredAnd >> rename: a to: b renamer: α [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
HPredAnd >> subst1: new for: old [
	self shouldBeImplemented 
]

{ #category : #'well-formedness' }
HPredAnd >> wfIn: gamma [ 
	^self conjuncts allSatisfy: [ :c | c wfIn: gamma ]
]