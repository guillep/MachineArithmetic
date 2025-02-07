"
The kind of AST used to represent fucntion symbols.
"
Class {
	#name : #Z3FuncDecl,
	#superclass : #Z3AST,
	#pools : [
		'Z3ASTKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #accessing }
Z3FuncDecl >> arity [
	^Z3 get_arity: ctx _: self

]

{ #category : #accessing }
Z3FuncDecl >> domain [
	^(1 to: self domainSize) collect: [ :j | self domainAt: j ]
]

{ #category : #accessing }
Z3FuncDecl >> domainAt: j [
	^Z3 get_domain: ctx _: self _: j-1
]

{ #category : #accessing }
Z3FuncDecl >> domainSize [
	^Z3 get_domain_size: ctx _: self
]

{ #category : #accessing }
Z3FuncDecl >> kind [
	^ FUNC_DECL_AST

]

{ #category : #accessing }
Z3FuncDecl >> name [
	"Return the name of the function (functor name) as a Smalltalk String"
	^ (Z3 get_decl_name: ctx _: self) asString

]

{ #category : #accessing }
Z3FuncDecl >> range [
	^Z3 get_range: ctx _: self
]

{ #category : #accessing }
Z3FuncDecl >> sort [
	^ Z3 get_sort: ctx _: self

]

{ #category : #applying }
Z3FuncDecl >> value [
	^ self valueWithArguments: {}

]

{ #category : #applying }
Z3FuncDecl >> value: arg [
	^ self valueWithArguments: { arg }

]

{ #category : #'function definition' }
Z3FuncDecl >> value: x is: fx [
	^self valueWithArguments: {x} is: fx
]

{ #category : #applying }
Z3FuncDecl >> value: arg1 value: arg2 [
	^ self valueWithArguments: { arg1. arg2 }

]

{ #category : #'function definition' }
Z3FuncDecl >> value: x value: y is: fxy [
	^self valueWithArguments: {x.y.} is: fxy
]

{ #category : #applying }
Z3FuncDecl >> value: arg1 value: arg2 value: arg3 [
	^ self valueWithArguments: { arg1. arg2. arg3 }

]

{ #category : #'function definition' }
Z3FuncDecl >> value: x value: y value: z is: fxyz [
	^self valueWithArguments: {x.y.z.} is: fxyz
]

{ #category : #applying }
Z3FuncDecl >> value: arg1 value: arg2 value: arg3 value: arg4 [
	^ self valueWithArguments: { arg1. arg2. arg3. arg4 }

]

{ #category : #'function definition' }
Z3FuncDecl >> valueIs: f_ [
	^self valueWithArguments: #() is: f_
]

{ #category : #applying }
Z3FuncDecl >> valueWithArguments: anArray [
	^ Z3 mk_app: ctx _: self _: anArray size _: anArray

]

{ #category : #'function definition' }
Z3FuncDecl >> valueWithArguments: args is: fargs [
	Z3 add_rec_def: self ctx _: self _: args size _: args _: fargs

]

{ #category : #copying }
Z3FuncDecl >> withName: aString [
	^aString functionFrom: self domain to: self range
]
