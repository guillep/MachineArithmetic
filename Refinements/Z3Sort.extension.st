Extension { #name : #Z3Sort }

{ #category : #'*Refinements' }
Z3Sort class >> _go: x y: y [
	x isEmpty
		ifTrue: [
			| s ss |
			y size = 1 ifTrue: [ ^y first ].
			s := y first.  ss := y allButFirst.
			"too early for Z3 #functionFrom:to:, because elab"
			^FFunc from: s to: (self _go: #() y: ss)
		] ifFalse: [
			| i is |
			i := x first.  is := x allButFirst.
			^FAbs int: i sort: (self _go: is y: y)
		]
]

{ #category : #'*Refinements' }
Z3Sort >> apply: θ [ 
	"Applying a Type Substitution
	apply :: TVSubst -> Sort -> Sort"
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> asRefinement [
	^self | [ :nu | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> checkNumeric: env [ 
	self shouldBeImplemented.
]

{ #category : #'*Refinements' }
Z3Sort >> fApp: argSorts [
"
fApp :: Sort -> [Sort] -> Sort
fApp = foldl' FApp,  so in coordinates,
fApp s ss = foldl' FApp s ss
"
	^argSorts inject: self into: [ :x :y | FApp s: x t: y ]
]

{ #category : #'*Refinements' }
Z3Sort >> falseRefinement [
	^self | [ :x | Bool false ]
]

{ #category : #'*Refinements' }
Z3Sort >> goMapSort: stepBlock [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> isMono [
	self subclassResponsibility
]

{ #category : #'*Refinements' }
Z3Sort >> mapSort: f [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort class >> mkFFunc: i sorts: ss [
"mkFFunc :: Int -> [Sort] -> Sort"
	^self _go: (0 to: i-1) y: ss

]

{ #category : #'*Refinements' }
Z3Sort >> proxyForVar: varName in: env [
	^self "I am already monomorphic"
]

{ #category : #'*Refinements' }
Z3Sort >> sortSubst: θ [
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> stepMapSort: f [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> subst: j _: tj [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> toProduct [
	^Product with: self
]

{ #category : #'*Refinements' }
Z3Sort >> trueRefinement [
	^self | [ :x | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> trueSortedReft [
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]

{ #category : #'*Refinements' }
Z3Sort class >> unify1: f maybeExpr: e tvSubst: θ sort: t1 sort: t2 [
	(t1 isKindOf: FVar) ifTrue: [ ^t2 unifyVar: f maybeExpr: e tvSubst: θ int: t1 i ].
	(t2 isKindOf: FVar) ifTrue: [ ^t1 unifyVar: f maybeExpr: e tvSubst: θ int: t2 i ].
	((t1 isKindOf: FApp) and: (t2 isKindOf: FApp)) ifTrue: [ ^self unifyMany: f maybeExpr: e tvSubst: θ sorts: { t1 s . t1 t } sorts: { t2 s . t2 t } ].
	((t1 isKindOf: FTC) and: (t2 isKindOf: FTC)) ifTrue: [ self shouldBeImplemented ].
	(t1 isKindOf: FAbs) ifTrue: [ self shouldBeImplemented ].
	(t2 isKindOf: FAbs) ifTrue: [ self shouldBeImplemented ].
	"TODO: insert ℝ ≅ ℤ here"
	"ℤ on either side:"
	(t1 isKindOf: Z3IntSort) ifTrue: [ t2 checkNumeric: f. ^θ ].
	(t2 isKindOf: Z3IntSort) ifTrue: [ t2 checkNumeric: f. ^θ ].

	((t1 isKindOf: FFunc) and: (t2 isKindOf: FFunc)) ifTrue: [ self shouldBeImplemented ].
	(t1 isKindOf: Z3UninterpretedSort) ifTrue: [ |a| a := t1 name getString. ^t2 checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a ].
	(t2 isKindOf: Z3UninterpretedSort) ifTrue: [ |a| a := t2 name getString. ^t1 checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a ].
	
	t1 = t2 ifTrue: [ ^θ ].
	Incompatible signal
]

{ #category : #'*Refinements' }
Z3Sort >> unify: t2 env: f fast: isFast [
"
Fast Unification; `unifyFast True` is just equality
"
	isFast ifFalse: [ self shouldBeImplemented ].
	^self=t2
		ifTrue: [TVSubst new]
		ifFalse: [nil]
]

{ #category : #'*Refinements' }
Z3Sort class >> unify: f maybeExpr: e sort: t1 sort: t2 [
	[^self unify1: f maybeExpr: e tvSubst: (Context readState: #tvSubst) sort: t1 sort: t2 ] runReader: #tvSubst initialState: TVSubst new
]

{ #category : #'*Refinements' }
Z3Sort class >> unifyMany: f maybeExpr: e tvSubst: θ sorts: ts sorts: ts_ [
"
unifyMany :: HasCallStack => Env -> Maybe Expr -> TVSubst -> [Sort] -> [Sort] -> CheckM TVSubst
"
	| zip |
	ts size = ts_ size ifFalse: [ self error ].
	zip := ts zip: ts_.
	zip collectAssociations: [ :t :t_ | self unify1: f maybeExpr: e tvSubst: θ sort: t sort: t_ ].
	"we destructively modify θ in place"
	^θ
]

{ #category : #'*Refinements' }
Z3Sort >> unifyVar: f maybeExpr: e tvSubst: θ int: i [
	(θ lookupVar: i)
		ifNil: [ ^θ updateVar: i _: self ]
		ifNotNil: [ :t_ | ^self shouldBeImplemented  ]
]

{ #category : #'*Refinements' }
Z3Sort >> z3sort [
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> | aPredicate [
	^ShallowRefinement base: self predicate: aPredicate
]

{ #category : #'*Refinements' }
Z3Sort >> × [ rhs
	^self toProduct × rhs
]

{ #category : #'*Refinements' }
Z3Sort >> ≅ [ rhs 
	self = rhs ifTrue: [^true].
	^(Product with: self) = rhs
]
