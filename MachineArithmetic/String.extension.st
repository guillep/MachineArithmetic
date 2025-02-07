Extension { #name : #String }

{ #category : #'*MachineArithmetic' }
String >> /// length [
	^self toBitVector: length

]

{ #category : #'*MachineArithmetic' }
String >> functionFrom: domainSorts to: rangeSort [
	^self toZ3Symbol mkFuncFrom: domainSorts to: rangeSort
]

{ #category : #'*MachineArithmetic' }
String >> predicateOver: domain [
	^self toZ3Symbol mkPredicateOver: domain
]

{ #category : #'*MachineArithmetic' }
String >> recursiveFunctionFrom: domainSorts to: rangeSort [
	^self toZ3Symbol mkRecFuncFrom: domainSorts to: rangeSort
]

{ #category : #'*MachineArithmetic' }
String >> toBitVector: xlen [
	^BitVector sym: self length: xlen
]

{ #category : #'*MachineArithmetic' }
String >> toBool [
	^Bool var: self
]

{ #category : #'*MachineArithmetic' }
String >> toDatatype: t [
	^t mkConst: self
]

{ #category : #'*MachineArithmetic' }
String >> toInt [
	^Int const: self
]

{ #category : #'*MachineArithmetic' }
String >> toReal [
	^Real const: self

	"Created: / 03-12-2021 / 14:22:08 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #'*MachineArithmetic' }
String >> toSort [
	^Z3Sort uninterpretedSortNamed: self
]
