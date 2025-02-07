Class {
	#name : #SortedReft,
	#superclass : #Object,
	#instVars : [
		'sr_sort',
		'sr_reft'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SortedReft class >> go_sortedReftConcKVars: ps _: ks _: gs _: aList t: t bindingsInSmt: bindingsInSmt [ 
	| x xs v p |
	aList isEmpty ifTrue: [ ^{ ps . ks . gs } ].
	x := aList first.
	xs := aList allButFirst.
	v := x key.
	p := x value.
	^(p isKindOf: PKVar)
		ifTrue: [ self go_sortedReftConcKVars: ps _: {KVSub vv: v sort: t kVar: p var subst: p s}, ks _: gs _: xs t: t bindingsInSmt: bindingsInSmt ]
		"TODO: PGrad"
		ifFalse: [ self go_sortedReftConcKVars: {p},ps _: ks _: gs _: xs t: t bindingsInSmt: bindingsInSmt ]
]

{ #category : #'instance creation' }
SortedReft class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SortedReft class >> sort: s reft: r [
	^self basicNew 
		sr_sort: s;
		sr_reft: r;
		yourself
]

{ #category : #visiting }
SortedReft >> accept: aVisitor [ 
	^SortedReft
		sort: sr_sort
		reft: (sr_reft accept: aVisitor)
]

{ #category : #'as yet unclassified' }
SortedReft >> bind [
	^self sr_reft symbol -> self
]

{ #category : #'as yet unclassified' }
SortedReft >> check: γ [ 
	| s v ra γ_ |
	s := sr_sort.  v := sr_reft symbol.  ra := sr_reft expr.
	γ_ := γ copy at: v put: s; yourself.
	^ra check: γ_
]

{ #category : #'as yet unclassified' }
SortedReft >> checkSorted: γ [
"checkSorted :: Checkable a => SrcSpan -> SEnv Sort -> a -> Maybe Doc"
	^self check: γ
]

{ #category : #'as yet unclassified' }
SortedReft >> concKVars: x bindingsInSmt: bindingsInSmt [ 
	"Deconstruct a SortedReft.
	Split a SortedReft into its concrete and KVar components.
	sortedReftConcKVars :: Symbol -> SortedReft -> ([Pred], [KVSub], [KVSub])
	cf. Types/Utils.hs
	
	This is really different from LH, because in Z3
	the define-fun command is just creating a macro."
	| ves rs t |
	t := self sr_sort.
	rs := sr_reft conjuncts.
	ves := rs collect: [ :eachReft |
		| v p |
		v := eachReft symbol.
		p := eachReft expr.
		v -> (p subst1: v->(t mkConst: x)) ].
	^self class go_sortedReftConcKVars: #() _: #() _: #() _: ves t: t bindingsInSmt: bindingsInSmt 
]

{ #category : #'as yet unclassified' }
SortedReft >> evaluate: e in: aBindEnv [
	| p boundArg boundArgSort |
	p := sr_reft expr evaluateIn: aBindEnv.
	p isBool ifFalse: [ self error: 'Non-bool constraint' ].
	p := p simplify.
	p == Bool true  ifTrue: [^p].
	p == Bool false ifTrue: [^p].
	boundArg := self sr_reft symbol.
	boundArgSort := aBindEnv sortOf: boundArg.
	^p substitute: (boundArgSort mkConst: boundArg) with: e
]

{ #category : #compilation }
SortedReft >> evaluateIn: anEvalEnv [
	^SortedReft
		sort: sr_sort
		reft: (sr_reft evaluateIn: anEvalEnv)
]

{ #category : #'as yet unclassified' }
SortedReft >> isConc [
	^sr_reft isConc
]

{ #category : #printing }
SortedReft >> printOn: aStream [ 
	aStream nextPutAll: '{ '.
	aStream nextPutAll: self sr_reft symbol.
	aStream nextPutAll: ' : '.
	self sr_sort printOn: aStream.
	aStream nextPutAll: ' | '.
	self sr_reft expr printOn: aStream.
	aStream nextPutAll: ' }'.
]

{ #category : #'as yet unclassified' }
SortedReft >> shiftSR: i [ 
	^self copy
		sr_reft: (self sr_reft shiftR: i);
		yourself
]

{ #category : #accessing }
SortedReft >> sr_reft [
	^ sr_reft
]

{ #category : #accessing }
SortedReft >> sr_reft: anObject [
	sr_reft := anObject
]

{ #category : #accessing }
SortedReft >> sr_sort [
	^ sr_sort
]

{ #category : #accessing }
SortedReft >> sr_sort: anObject [
	sr_sort := anObject
]

{ #category : #'as yet unclassified' }
SortedReft >> top [
	^self "????"
]

{ #category : #'as yet unclassified' }
SortedReft >> trueSortedReft [
	^self
]

{ #category : #'as yet unclassified' }
SortedReft >> updSortedReft_kve: kve p: p [
	^SortedReft
		sort: self sr_sort
		reft: (self sr_reft copy
		             expr: (p predExpr: kve);
		             yourself)
]
