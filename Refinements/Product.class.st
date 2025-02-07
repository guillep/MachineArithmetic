"
I represent a Cartesian product of zero or more terms.
For example, ℤ × ℤ is the set of all ordered-pairs of integers.
Product is a monoid under #×, with (Product new) acting as the unit,
and ∀A,B,C. A × (B × C) = (A × B) × C.
"
Class {
	#name : #Product,
	#superclass : #Array,
	#type : #variable,
	#category : #Refinements
}

{ #category : #converting }
Product >> asArray [
	^Array withAll: self
]

{ #category : #'as yet unclassified' }
Product >> inventFormalArgumentsFor: functor [ 
	^self asArray collectWithIndex: [ :argSort :j | ('nnf_argºº', functor intSymbol: j-1) -> argSort ]
]

{ #category : #'as yet unclassified' }
Product >> mkRelationNamed: aString [ 
	^aString functionFrom: self to: Bool sort
]

{ #category : #printing }
Product >> printOn: aStream [
	aStream nextPut: $(.
	self do: [:element | aStream print: element] separatedBy: [ aStream
		space;
		nextPut: Character multiplicationSign;
		space ].
	aStream nextPut: $)
]

{ #category : #converting }
Product >> toProduct [
	^self
]

{ #category : #monoid }
Product >> × [ C
	"The operation of the 'Product' monoid.
	For example, if the receiver is something like A×B, answer A×B×C.
	"
	^self, C toProduct
]

{ #category : #comparing }
Product >> ≅ [ rhs 
	self = rhs ifTrue: [^true].
	^self = (Product with: rhs)
]
