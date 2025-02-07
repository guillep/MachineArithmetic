Class {
	#name : #QualifParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Parser'
}

{ #category : #tests }
QualifParserTest >> testQual [
	| q |
	q := QualifParser new end parse: 'qualif Geq(v:int, n:int): (n <= v)'.
	self assert: q params size equals: 2.

]

{ #category : #tests }
QualifParserTest >> testQualParam [
	| qp |
	qp := QualifParser new qualParam end parse: 'x:int'.
	self assert: qp symbol equals: 'x'
]

{ #category : #tests }
QualifParserTest >> testQualParams [
	| qps |
	qps := QualifParser new qualParams end parse: '(x:int, y:int)'.
	self assert: qps first symbol equals: 'x'.
	self assert: qps last  symbol equals: 'y'.
]

{ #category : #tests }
QualifParserTest >> testQuals [
	| qs |
	qs := ΛκParser new quals end parse:
'⟦qualif Pos(v:int):     (0 <= v)⟧
⟦qualif Geq(v:int, n:int): (n <= v)⟧'.
	self assert: qs first params size equals: 1.
	self assert: qs last params size equals: 2.

]
