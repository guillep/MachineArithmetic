Class {
	#name : #Found,
	#superclass : #SESearch,
	#instVars : [
		'x'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Found class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
Found class >> x: x [
	^self basicNew x: x; yourself
]

{ #category : #accessing }
Found >> x [
	^ x
]

{ #category : #accessing }
Found >> x: anObject [
	x := anObject
]
