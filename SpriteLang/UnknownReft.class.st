Class {
	#name : #UnknownReft,
	#superclass : #'ΛReft',
	#category : #SpriteLang
}

{ #category : #'instance creation' }
UnknownReft class >> new [
	^self basicNew
]

{ #category : #semigroup }
UnknownReft >> , anotherReft [
	^anotherReft
]

{ #category : #'fresh monad' }
UnknownReft >> freshR: Γ _: t [
"
freshR l g t Unknown      = freshK l g t
" 
	^Γ freshK: t
]

{ #category : #testing }
UnknownReft >> isKnown [
	^false
]

{ #category : #printing }
UnknownReft >> printOn: aStream [
	aStream nextPut: Character starOperator
]

{ #category : #'F.Subable' }
UnknownReft >> subst1: su [
	^self
]

{ #category : #'F.Subable' }
UnknownReft >> subst: su [
	^self
]

{ #category : #'F.Subable' }
UnknownReft >> substa: f [
	^self
]

{ #category : #'F.Subable' }
UnknownReft >> substf: f [
	^self
]

{ #category : #'F.Subable' }
UnknownReft >> syms [
	^#()
]
