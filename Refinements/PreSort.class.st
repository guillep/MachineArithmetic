"
I am the superclass of all brain-damaged Sorts which are not Z3Sorts.
"
Class {
	#name : #PreSort,
	#superclass : #Object,
	#classVars : [
		'hotel'
	],
	#category : #Refinements
}

{ #category : #hotel }
PreSort class >> printGuestInRoom: j on: aStream [
	"If room j in the Sort Hotel is occupied, print the guest on aStream.
	 If there is no room j (aka it's empty), do nothing."
	| guest |
	guest := hotel at: j ifAbsent: [ ^nil ].
	aStream space.
	aStream nextPut: (Character codePoint: 16r2302).
	guest printOn: aStream
]

{ #category : #hotel }
PreSort class >> resetHotel [
	hotel := IndexedSet new
]

{ #category : #comparing }
PreSort >> = rhs [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PreSort >> checkFunSort [
	"cf. SortCheck.hs"
	self error: 'NonFunction'
]

{ #category : #'as yet unclassified' }
PreSort >> fApp: argSorts [
	"Same as in Z3Sort."
	^argSorts inject: self into: [ :x :y | FApp s: x t: y ]
]

{ #category : #'as yet unclassified' }
PreSort >> goMapSort: stepBlock [
	^self
]

{ #category : #comparing }
PreSort >> hash [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> instantiate [
	^self
]

{ #category : #'as yet unclassified' }
PreSort >> mapSort: f [
"
mapSort :: (Sort -> Sort) -> Sort -> Sort
cf. Visitor.hs
"
	^self stepMapSort: f
]

{ #category : #'as yet unclassified' }
PreSort >> mkConst: name [
	^PreConstant name: name sort: self
]

{ #category : #sorting }
PreSort >> sortSubst: θ [
"
------------------------------------------------------------------------
sortSubst                 :: SortSubst -> Sort -> Sort
------------------------------------------------------------------------
sortSubst θ t@(FObj x)    = fromMaybe t (M.lookup x θ)
sortSubst θ (FFunc t1 t2) = FFunc (sortSubst θ t1) (sortSubst θ t2)
sortSubst θ (FApp t1 t2)  = FApp  (sortSubst θ t1) (sortSubst θ t2)
sortSubst θ (FAbs i t)    = FAbs i (sortSubst θ t)
sortSubst _  t            = t
"
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PreSort >> stepMapSort: f [
"cf. Visitor.hs"
	^(f value: self) goMapSort: [ :x | x stepMapSort: f ]
]

{ #category : #'as yet unclassified' }
PreSort >> trueSortedReft [
	"Same as Z3Sort."
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]

{ #category : #accessing }
PreSort >> value: arg [
	self subclassResponsibility
]
