"
Tests equivalent to z3/examples/c/test_capi.c
"
Class {
	#name : #Z3CAPITest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
Z3CAPITest >> exampleArray2: n [
	"Instance of testArray2 with n arrays"
	
	| arraySort arrays distinct solver sat |

	arraySort := Z3Sort bool --> Z3Sort bool.
	arrays := (0 to: n - 1) collect: [ :i |
		| s |
		s := Z3Symbol from: i.
		Z3AST mkConst: s ofSort: arraySort ].
	
	distinct := arraySort ctx mkDistinct: arrays.
	solver := Z3Solver on: arraySort ctx.
	solver assert: distinct.
	sat := solver check.
	solver del.
	^sat
]

{ #category : #tests }
Z3CAPITest >> testArray1 [
	"Prove
		store(a1, i1, v1) = store(a2, i2, v2) implies (i1 = i3 or i2 = i3 or select(a1, i3) = select(a2, i3)).
   This example demonstrates how to use the array theory."
	| s arraySort a1 a2 i1 i2 i3 v1 v2 st1 st2 sel1 sel2 ante conseq thm |
	arraySort := Z3Sort int --> Z3Sort int.
	a1 := arraySort mkConst: 'a1'.
	a2 := arraySort mkConst: 'a2'.
	i1 := Z3Sort int mkConst: 'i1'.
	i2 := Z3Sort int mkConst: 'i2'.
	i3 := Z3Sort int mkConst: 'i3'.
	v1 := Z3Sort int mkConst: 'v1'.
	v2 := Z3Sort int mkConst: 'v2'.
	
	st1 := a1 arrayStore: i1 put: v1.
	st2 := a2 arrayStore: i2 put: v2.
	sel1 := a1 arraySelect: i3.
	sel2 := a2 arraySelect: i3.
	
	ante := st1 eq: st2.
	conseq := Bool or: (Array
		with: (i1 eq: i3)
		with: (i2 eq: i3)
		with: (sel1 eq: sel2)).
	thm := ante ==> conseq.
	thm astToString.
	
	s := Z3Solver new.
	s proveValid: thm.
	s del
]

{ #category : #tests }
Z3CAPITest >> testArray2 [
	"Show that distinct(a_0, ... , a_n) is unsatisfiable
	 when a_i's are arrays from boolean to boolean and n > 4.
	 This example also shows how to use the distinct construct."
	| sats |
	sats := (2 to: 5) collect: [ :n | self exampleArray2: n ].
	self assert: sats asArray equals: {  true. true. true. false }

]

{ #category : #tests }
Z3CAPITest >> testArray3 [
	"Simple array type construction/deconstruction example."
	| arraySort |
	arraySort := Int sort --> Bool sort.
	self assert: arraySort domain equals: Int sort.
	self assert: arraySort range equals: Bool sort.
]

{ #category : #tests }
Z3CAPITest >> testBinaryTree [
	"Create a binary tree datatype of the form
		BinTree ::=
			| nil
			| node(value : Int, left : BinTree, right : BinTree)
	"
	| cell nill node1 node2 node3 |
	cell := Z3Datatype named: 'BinTree'.
	cell declare: 'node' accessors: { 
		'V'     -> Int sort. "Here is a problem with the DNU approach.  Can't use #value."
		'left'  -> cell.
		'right' -> cell
		 }.
	cell declare: 'nil'.
	cell := cell create.
	nill := cell nil.
	node1 := cell node: 10 _: nill _: nill.
	node2 := cell node: 30 _: node1 _: nill.
	node3 := cell node: 20 _: node2 _: node1.
	self assert: (node1 ~== nill) isValid.
	self assert: (node1 left === nill) isValid.
	self assert: (node3 right === node1) isValid.
	self assert: (node2 is_nil not) isValid.
	self assert: (node2 V >= 0) isValid
]

{ #category : #tests }
Z3CAPITest >> testBitvector1 [
	"Simple bit-vector example.
	This example disproves that x - 10 <= 0 IFF x <= 10 for (32-bit) machine integers."
	| solver x zero ten thm counterexample |
	solver := Z3Solver new.
	x := 'x' toBitVector: 32.
	zero := 0 toBitVector: 32.
	ten := 10 toBitVector: 32.
	thm := x <= ten iff: x - ten <= zero.
	counterexample := solver proveNotValid: thm.
	self assert: (counterexample constants includesKey: 'x').
	solver del
]

{ #category : #tests }
Z3CAPITest >> testBitvector1a [
	"Just like testBitvector1 but coerces integers to BVs."
	| solver x thm |
	solver := Z3Solver new.
	x := 'x' toBitVector: 32.
	thm := x <= 10 iff: x - 10 <= 0.
	solver proveNotValid: thm.
	solver del
]

{ #category : #tests }
Z3CAPITest >> testDemorgan [
	"Demonstration of how Z3 can be used to prove validity of
	 De Morgan's Duality Law: {e not(x and y) <-> (not x) or ( not y) }"
	| x y notX notY XandY ls rs conjecture negatedConjecture solver sat |

	x := Bool var: 0.
	y := Bool var: 1.
	
	self assert: x isApp.
	
	"De Morgan - with a negation around"
	"!(!(x && y) <-> (!x || !y))"
	notX := x not.
	notY := y not.
	XandY := x & y.
	
	ls := XandY not.
	rs := notX | notY.
	
	conjecture := ls iff: rs.
	negatedConjecture := conjecture not.
	
	solver := Z3Solver new.
	solver assert: negatedConjecture.
	sat := solver check.
	"The negated conjecture was unsatisfiable, hence the conjecture is valid"
	self deny: sat.
	
	solver del

]

{ #category : #tests }
Z3CAPITest >> testEnum [
	"Create an enumeration data type."
	| fruit consts testers apple banana orange fruity solver |
	consts  := Array new: 3.
	testers := Array new: 3.
	fruit := Z3Context current mkEnumerationSort: 'fruit'
		elements: { 'apple'. 'banana'. 'orange'. }
		consts: consts
		testers: testers.
	"it's instructive to look around the consts and testers at this point"
	apple  := consts first value.
	banana := consts second value.
	orange := consts third value.
	"Apples are different from oranges"
	self assert: apple ~== orange.
	"Apples pass the apple test"
	self assert: (testers first value: apple) simplify.
	"Oranges pass the apple test"
	self deny: (testers first value: orange).
	
	"If something is fruity, then it is an apple, banana, or orange"
	fruity := fruit mkConst: 'fruity'.
	solver := Z3Solver new.
	solver proveValid: (Bool or: { fruity===apple. fruity===banana. fruity===orange. }).
	solver del.

]

{ #category : #tests }
Z3CAPITest >> testErrorHandling1 [
	| zero ten bvsge |
	
	zero := 0 toInt.
	ten := 10 toInt.
	
	self should: [bvsge := Z3 mk_bvsge: zero ctx _: zero _: ten] raise: Z3Error
]

{ #category : #tests }
Z3CAPITest >> testEval [
	"Demonstrate how to use #Z3_eval."
	| ctx solver x y two m x_plus_y |
	ctx := Z3Context fromDefault.
	x := ctx mkIntVar: 'x'.
	y := ctx mkIntVar: 'y'.
	two := ctx mkInt: 2.
	
	solver := Z3Solver on: ctx.
	solver assert: x < y.
	solver assert: x > two.
	solver check.
	m := solver getModel.
	x_plus_y := m eval: (x+y) completion: true.
	self assert: x_plus_y astToString equals: '7'.
	x_plus_y printOn: Transcript.
	Transcript cr.
	
	"m decRef."
	solver del.
	ctx del
	
]

{ #category : #tests }
Z3CAPITest >> testFindModel0 [
	"Find a model for
		x "
	| x y solver sat model ass |

	((Smalltalk respondsTo: #isSmalltalkX) and:[Smalltalk isSmalltalkX]) ifTrue:[
		self skip: 'Not supported on Smalltalk/X, uses Pharo compiler API'
	].

	x := Bool var: 'x'.
	y := Bool var: 'y'.
	
	solver := Z3Solver new.
	solver assert: x. " + y."
	sat := solver check.
	
	"this is the test for now; this is part of void check() in test_capi.c"
	self assert: sat.
	model := solver getModel.
	ass := Smalltalk compiler source: (model toString); environment: (Dictionary new at: 'x' put: 'XXX'; yourself); evaluate.
	self assert: ass key equals: 'XXX'.
	self assert: ass value equals: true.
]

{ #category : #tests }
Z3CAPITest >> testFindModel1 [
	"Find a model for
		x xor y "
	| x y solver sat model |
	x := Bool var: 'x'.
	y := Bool var: 'y'.
	
	solver := Z3Solver new.
	solver assert: x + y.
	sat := solver check.
	
	"this is the test for now; this is part of void check() in test_capi.c"
	self assert: sat.
	model := solver getModel.
	Transcript cr; show: model toString
]

{ #category : #tests }
Z3CAPITest >> testFindModel2 [
	"Find a model for
		x < y + 1, x > 2.
	 Then, assert not(x = y), and find another model.
	"
	| solver x y one two yPlusOne c1 c2 sat model |
	x := Int var: 'x'.
	y := Int var: 'y'.
	one := 1 toInt.
	two := 2 toInt.
	yPlusOne := y + one.
	c1 := x < yPlusOne.
	c2 := x > two.

	solver := Z3Solver new.
	solver assert: c1.
	solver assert: c2.
	"this is the test for now; this is part of void check() in test_capi.c"
"	sat := solver check.
	self assert: sat equals: #TRUE.
	model := solver getModel.
	Transcript cr; show: model toString." "x->3, y->3"
	"Now assert not(x = y) in the same solver"
	solver assert: (x eq: y) not.
	sat := solver check.
	self assert: sat.
	model := solver getModel.
	Transcript cr; show: model toString. "x->3, y->4"
	solver del
]

{ #category : #tests }
Z3CAPITest >> testITE [
	"Test ite-term (if-then-else terms)."
	| f one zero ite |
	f := Bool false.
	one := 1 toInt.
	zero := 0 toInt.
	ite := f ifThen: one else: zero.
	ite astToString.
]

{ #category : #tests }
Z3CAPITest >> testNumeral [
	"Demonstrate different ways of creating rational numbers: decimal and fractional representations."
	| s real_sort n1 n2 |
	s := Z3Solver new.
	"create a big number"
	real_sort := Z3Sort real.
	n1 := real_sort numeralFrom: '-1/3'.
	n2 := real_sort numeralFrom: '-0.33333333333333333333333333333333333333333333333333'.
	s proveValid: (n1 eq: n2) not.
	s del
]

{ #category : #tests }
Z3CAPITest >> testProve1 [
	"Prove x = y implies g(x) = g(y), and
   disprove x = y implies g(g(x)) = g(y).

   This function demonstrates how to create uninterpreted types and
   functions."
	| solver U g x y gx gy ggx |
	U := Z3Sort uninterpretedSortNamed: 'U'.
	
	"declare function g"
	g := 'g' functionFrom: (Array with: U) to: U.
	
	x := U mkConst: 'x'.
	y := U mkConst: 'y'.
	
	gx := g value: x.
	gy := g value: y.
	
	solver := Z3Solver new.
	solver assert: (x eq: y).
	solver proveValid: (gx eq: gy).
	ggx := g value: gx.
	self flag: #TODO.  "I don't understand why the below fails to prove a counterexample"
	"solver proveNotValid: (ggx eq: gy)."
	solver del.
]

{ #category : #tests }
Z3CAPITest >> testPushPop [
	"Show how push & pop can be used to create 'backtracking' points.
   This example also demonstrates how big numbers can be created in Z3."
	| ctx s brazilion int_sort x y  big_number three |
	ctx := Z3Context fromDefault.
	s := Z3Solver on: ctx.
	
	"create a big number"
	int_sort := Z3Sort intSortOn: ctx.
	brazilion := '1000000000000000000000000000000000000000000000000000000'.
	big_number := int_sort numeralFrom: brazilion.
	self assert: big_number astToString equals: brazilion.
	
	"create number 3"
	three := int_sort numeralFrom: '3'.
	self assert: three astToString equals: '3'.
	
	"create x, assert x > brazilion"
	x := ctx mkIntVar: 'x'.
	s assert: x > big_number.
	
	"create a backtracking point"
	self assert: s numScopes equals: 0.
	s push.
	self assert: s numScopes equals: 1.
	
	"assert x < 3, which is inconsistent with x > brazilion"
	s assert: x < three.
	self assert: s check == false.
	
	"backtrack: the constraint x <= 3 will be removed,
	since it was sserted after the last Z3_solver_push."
	s pop.
	self assert: s numScopes equals: 0.

	"the context is consistent again."
	self assert: s check == true.

	"new constraints can be asserted..."

	"create y"
	y := ctx mkIntVar: 'y'.
	s assert: y > x.
	"the context is still consistent"
	self assert: s check == true.
	"s getModel inspect."
	
	s del.
	ctx del 
]

{ #category : #tests }
Z3CAPITest >> testQuantifier [
	"Prove that
		f(x, y) = f(w, v)
	implies
		y = v
	when f is injective in the second argument."
	| f solver x y w v fxy fwv |
	Z3 global_param_set: 'smt.mbqi.max_iterations' _: '10'.
	
	f := 'f' functionFrom: { Int sort. Int sort. } to: Int sort.
	solver := Z3Solver new.
	solver assertInjective: f in: 2.
	x := Int var: 'x'.
	y := Int var: 'y'.
	v := Int var: 'v'.
	w := Int var: 'w'.
	fxy := f value: x value: y.
	fwv := f value: w value: v.
	solver assert: (fxy eq: fwv).
	solver push.
	solver proveValid: (y eq: v).
	solver pop.
	"However, because nothing says f is injective in the first argument,
	trying to prove x=w fails:"
	self should: [solver proveValid: (x eq: w)] raise: UnknownValidity
]

{ #category : #tests }
Z3CAPITest >> testSMT2Parser [
	"Demonstrates how to use SMT2 parser."
	| fs |
	fs := Z3ASTVector parseSmtlib2String: '(declare-fun a () (_ BitVec 8)) (assert (bvuge a #x10)) (assert (bvule a #xf0))'.
	self assert: (fs printString beginsWith: '(ast-vector')
	
]

{ #category : #tests }
Z3CAPITest >> testSubstituteSubexpressions [
	"Demonstrates how to use the function Z3_substitute to replace subexpressions in a Z3 AST."
	| Z a b f g fab ga ffabga r |
	Z := Z3Sort int.
	a := 'a' toInt.  	b := 'b' toInt.
	f := 'f' functionFrom: {Z.Z} to: Z.
	g := 'g' functionFrom: {Z} to: Z.
	fab := f value: a value: b. "f(a,b)"
	ga := g value: a. "g(a)"
	ffabga := f value: fab value: ga. "f(f(a,b), g(a))"
	
	r := ffabga substituteAll: {b. ga} with: {0 toInt. 1 toInt}.
	r astToString.
	self assert: r isApp.
	self assert: r arity equals: 2.
	self assert: (r argAt: 2) astToString equals: '1'

]

{ #category : #tests }
Z3CAPITest >> testSubstituteVars [
	"Demonstrates how to to replace free variables with expressions in an AST."
	| x0 x1 a b gb f g f01 ff010 r intTy |
	intTy := Z3Sort int.
	x0 := intTy mkBound: 0.
	x1 := intTy mkBound: 1.
	f := 'f'
		functionFrom: (Array with: intTy with: intTy)
		to: intTy.
	g := 'g'
		functionFrom: (Array with: intTy)
		to: intTy.
	f01 := f value: x0 value: x1. "f(x0,x1)"
	ff010 := f value: f01 value: x0. "f(f(x0,x1),x0)"
	a := Int var: 'a'.
	b := Int var: 'b'.
	gb := g value: b. "g(b)"
	"Replace x0 -> a, x1 -> g(b) in f(f(x0,x1),x0),
	giving f(f(a,g(b)),a)"
	r := ff010 substituteVarsWith: (Array with: a with: gb).
	self assert: r astToString equals: '(f (f a (g b)) a)'.
	self assert: r isInt.
	self assert: r isApp.
	self assert: r functorName equals: 'f'.
	self assert: (r argAt: 2) astToString equals: 'a'

]

{ #category : #tests }
Z3CAPITest >> testUnsatCore [
	"Prove a theorem and extract, and print the proof.
	This example illustrates the use of #Z3_check_assumptions."
	| pa pb pc pd p1 p2 p3 p4 f1 f2 f3 f4 result assumptions solver |
	pa := 'PredA' toBool. pb := 'PredB' toBool. pc := 'PredC' toBool. pd := 'PredD' toBool.
	p1 := 'P1' toBool. p2 := 'P2' toBool. p3 := 'P3' toBool. p4 := 'P4' toBool.
	assumptions := {p1.p2.p3.p4.} collect: #not.
	f1 := Bool and: { pa. pb. pc. }.
	f2 := Bool and: { pa. pb not. pc. }.
	f3 := Bool and: { pa not. pc not. }.
	f4 := pd.
	solver := Z3Solver new.
	solver assert: (Bool or: { f1.p1. }).
	solver assert: (Bool or: { f2.p2. }).
	solver assert: (Bool or: { f3.p3. }).
	solver assert: (Bool or: { f4.p4. }).
	result := solver checkAssumptions: assumptions.
	self assert: result == false.
	self assert: solver unsatCore size equals: 2.
	"solver proof." "TODO"
	solver del
	
]
