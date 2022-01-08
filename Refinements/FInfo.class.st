Class {
	#name : #FInfo,
	#superclass : #HornInfo,
	#category : #Refinements
}

{ #category : #logic }
FInfo >> convertFormat [
	"Convert FInfo query to SInfo."
	| bindm_fi1 fi1 |
	bindm_fi1 := cm injectWithKey: (Dictionary new -> self) into: [ :m_fi :i :c | c outVV: m_fi i: i ].
	fi1 := bindm_fi1 value.
	fi1 cm: (fi1 cm collect: [ :subc | subc toSimpC: bindm_fi1 key ]).
	^fi1 as: SInfo 
]

{ #category : #logic }
FInfo >> reduce [
	^self "BOGUS, should implement"
]

{ #category : #logic }
FInfo >> remakeQual [
	"Destructively remake quals."
	quals := quals collect: [ :qual | qual remake ].
	^self
]

{ #category : #logic }
FInfo >> simplify [
	| reducedFi fi1 si0 si1 si2 si3 si4 si5 si6 | self halt.
	reducedFi := self reduce.
	fi1 := reducedFi remakeQual.
	si0 := fi1 convertFormat.
	si1 := si0 sanitize.
	si2 := si1 wfcUniqify.
	si3 := si2 "renameAll".
	si4 := si3 "defunctionalize".
	si5 := si4 "elaborate".
	si6 := si5 "expand, if extensionality".
	"if rewrite axioms, instantiate then ^#Nothing"
	^si6
]

{ #category : #solving }
FInfo >> solve [
	^self solve1
	
]

{ #category : #solving }
FInfo >> solve1 [
	^self slice solveNative
	
]

{ #category : #solving }
FInfo >> solveNative [
	^self solveNative1
	
]

{ #category : #solving }
FInfo >> solveNative1 [
	| si6 res |
	si6 := self simplify.
	res := si6 solve.
	^res
	
]