Class {
	#name : #CardanoTartagliaContext,
	#superclass : #Object,
	#instVars : [
		'env'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
CardanoTartagliaContext class >> ofSortedVariables: aDictionary [
	| ctx |
	ctx := self basicNew.
	aDictionary keysAndValuesDo: [ :var :sort |
		ctx tempNamed: var put: (sort mkConst: var) ].
	^ctx
]

{ #category : #'instance creation' }
CardanoTartagliaContext class >> ofVariables: aDictionary [
	| ctx |
	ctx := self basicNew.
	aDictionary keysAndValuesDo: [ :var :value |
		ctx tempNamed: var put: value ].
	^ctx
]

{ #category : #'smalltalk context' }
CardanoTartagliaContext >> dummyMethod [
]

{ #category : #accessing }
CardanoTartagliaContext >> env [
	env isNil ifTrue: [env := Dictionary new].
	^ env
]

{ #category : #GT }
CardanoTartagliaContext >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable
		title: 'Variables';
		display: [ env associations ];
		"children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];"
			column: 'Name' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
		selectionAct: [ :table | 
			table rawSelection do: [ :assoc | self removeKey: assoc key ].
			table update
			]
			entitled: 'Remove item(s)';
		selectionPopulate: #selection
			entitled: 'Open key'
			with: [ :table | ( table rawSelection collect: #key ) gtInspectorInterestingObject ];
		beMultiple;
		send: [ :selection | 
			"withSmalltalkSearch;
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'"
			selection
				ifNil: [ nil ]
				ifNotNil: [ selection size = 1
						ifTrue: [ selection anyOne value ]
						ifFalse: [ selection collect: #value ]
					]
			]
]

{ #category : #'smalltalk context' }
CardanoTartagliaContext >> method [
	^CardanoTartagliaContext >> #dummyMethod
]

{ #category : #'smalltalk context' }
CardanoTartagliaContext >> receiver [
	^nil
]

{ #category : #accessing }
CardanoTartagliaContext >> tempNamed: aString [
	^self env at: aString
]

{ #category : #accessing }
CardanoTartagliaContext >> tempNamed: aString put: value [
	self env at: aString put: value 
]

{ #category : #accessing }
CardanoTartagliaContext >> tempNames [
	^self env keys
]
