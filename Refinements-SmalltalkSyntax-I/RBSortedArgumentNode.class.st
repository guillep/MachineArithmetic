Class {
	#name : #RBSortedArgumentNode,
	#superclass : #BoundArgumentNode,
	#instVars : [
		'sort',
		'reft'
	],
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'instance creation' }
RBSortedArgumentNode class >> named: v sort: s reft: r [
	^(self named: v)
		sort: s;
		reft: r;
		yourself
]

{ #category : #grammar }
RBSortedArgumentNode class >> parseBoundVariableNode: x parser: anRBParser [
	| sortNode refinementNode |
	(anRBParser currentToken isBinary and: [anRBParser currentToken value = '∈']) ifFalse: [self error]. anRBParser step.
	(anRBParser currentToken isSpecial and: [ anRBParser currentToken value = $( ])
		ifTrue: [ 
			anRBParser step.
			sortNode := anRBParser sequenceNodeClass new.
			(anRBParser parseStatements: false into: sortNode).
			(anRBParser currentToken isSpecial and: [ anRBParser currentToken value = $) ]) ifFalse: [self error].
			anRBParser step
		] ifFalse: [
			sortNode := anRBParser currentToken.
			anRBParser step
		].
	(anRBParser currentToken isSpecial and: [ anRBParser currentToken value = $( ]) ifTrue: [
		anRBParser step.
		refinementNode := anRBParser sequenceNodeClass new.
		(anRBParser parseStatements: false into: refinementNode).
		(anRBParser currentToken isSpecial and: [ anRBParser currentToken value = $) ]) ifFalse: [self error]. anRBParser step.
	].
	^self named: x name sort: sortNode reft: refinementNode
]

{ #category : #quantification }
RBSortedArgumentNode >> forceCorrectClassOf: aBlockNode [
	^aBlockNode as: RBQuantificationBlockNode 
]

{ #category : #accessing }
RBSortedArgumentNode >> parent: aRBProgramNode [ 
	parent := aRBProgramNode.
	sort parent: aRBProgramNode.
	reft isNil ifFalse: [ reft parent: aRBProgramNode ]
]

{ #category : #accessing }
RBSortedArgumentNode >> reft [
	^ reft
]

{ #category : #accessing }
RBSortedArgumentNode >> reft: anObject [
	reft := anObject
]

{ #category : #accessing }
RBSortedArgumentNode >> sort [
	^ sort
]

{ #category : #accessing }
RBSortedArgumentNode >> sort: anObject [
	sort := anObject
]