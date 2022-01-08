Class {
	#name : #DelayedSubst,
	#superclass : #HPred,
	#instVars : [
		'substitutions',
		'expression'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
DelayedSubst class >> from: old to: new in: anExpression [
	| dict |
	dict := Dictionary newFromAssociations: { old->new. }.
	^self subst: dict in: anExpression
]

{ #category : #'as yet unclassified' }
DelayedSubst class >> subst: substitutions in: anExpression [
	^self basicNew
			substitutions: substitutions;
			expression: anExpression;
			yourself
]

{ #category : #comparing }
DelayedSubst >> = another [
	self class = another class ifFalse: [ ^false ].
	expression = another expression ifFalse: [ ^false ].
	^substitutions = another substitutions
]

{ #category : #'as yet unclassified' }
DelayedSubst >> boundKVars [
	^#()
]

{ #category : #'term rewriting' }
DelayedSubst >> evaluateIn: aBindEnv [
	| substs |
	substs := self substitutions associations collect: [ :ass |
		(aBindEnv variableNamed: ass key) -> (aBindEnv evaluate: ass value)].
	^(self expression evaluateIn: aBindEnv) inEnvironment: (Dictionary newFromAssociations: substs)
]

{ #category : #accessing }
DelayedSubst >> expression [
	^ expression
]

{ #category : #accessing }
DelayedSubst >> expression: anObject [
	expression := anObject
]

{ #category : #comparing }
DelayedSubst >> hash [
	^expression hash
]

{ #category : #'as yet unclassified' }
DelayedSubst >> isTauto [
	^expression isTauto
]

{ #category : #'as yet unclassified' }
DelayedSubst >> kvarsExpr [
	"BOGUS: Please do something!"
	^#()
]

{ #category : #printing }
DelayedSubst >> printOn: aStream [
	expression printOn: aStream.
	aStream nextPut: $[.
	self printSubstitutionsOn: aStream.
	aStream nextPut: $].
]

{ #category : #printing }
DelayedSubst >> printSubstitutionsOn: aStream [
	self substitutions associations
		do: [ :oneSubst |
			aStream nextPutAll: oneSubst value asString;
				nextPut: $/;
				nextPutAll: oneSubst key asString ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #'as yet unclassified' }
DelayedSubst >> pruneTauts [
	^DelayedSubst subst: substitutions in: expression pruneTauts
]

{ #category : #'term rewriting' }
DelayedSubst >> rename: a to: b renamer: α [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
DelayedSubst >> substitutions [
	^ substitutions
]

{ #category : #accessing }
DelayedSubst >> substitutions: anObject [
	substitutions := anObject
]

{ #category : #'as yet unclassified' }
DelayedSubst >> uniq1: α [
	"COMPLETELY BOGUS"
	^self
]