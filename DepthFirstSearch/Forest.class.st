Class {
	#name : #Forest,
	#superclass : #Object,
	#instVars : [
		'trees'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
Forest class >> leaves: leaves [
	"Construct a forest of depth 1, where each tree contains only a root."
	^self of: (leaves collect: [ :leaf | Tree leaf: leaf ])
]

{ #category : #'instance creation' }
Forest class >> of: trees [
	"Construct a forest from a list of trees."
	^self basicNew
		trees: trees;
		yourself
]

{ #category : #'topological sorting' }
Forest >> postorder: aCollection [
	self shouldBeImplemented 
]

{ #category : #accessing }
Forest >> trees [
	^ trees
]

{ #category : #accessing }
Forest >> trees: anObject [
	trees := anObject
]