Extension { #name : #Context }

{ #category : #'*PreSmalltalks' }
Context class >> readState: marker [
	| launchContext |
	launchContext := thisContext sender findContextSuchThat: [ :ctx |
		ctx isBlockContext not and: [
			ctx methodSelector = #runReader:initialState: and: [ 
				(ctx tempNamed: #marker) = marker ] ] ].
	^launchContext tempNamed: #s
]
