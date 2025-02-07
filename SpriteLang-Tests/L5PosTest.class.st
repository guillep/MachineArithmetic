Class {
	#name : #L5PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
L5PosTest >> test_append00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| len v = 0]
  | Cons (x:''a, xs:list(''a)) => [v| len v = 1 + len(xs)]
  ;

⟦val append : xs:list(''a) => ys:list(''a) => list(''a)[v|len v = len(xs) + len(ys)]⟧
let rec append = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => let rest = append(t, ys);
                    Cons(h, rest)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_cons00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| (len value: v) === 0]
  | Cons (x:''a, xs:list(''a)) => [v| (len value: v) === (1 + (len value: xs))]
  ;

⟦val singleton : ''a => list(''a)[v|(len value: v) === 1]⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_foldRight00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_head00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_head01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_isort00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_isort01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_listSet [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_nil00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| (len value: v) === 0]
  | Cons (x:''a, xs:list(''a)) => [v| (len value: v) === (1 + (len value: xs))]
  ;

⟦val singleton : ''a => list(''a)[v|(len value: v) === 0]⟧
let singleton = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist00 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val bar : apple:int => horse: olist(int[v| apple < v ]) => olist(int)⟧
let bar = (apple, horse) => {
  OCons(apple, horse)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist01 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val foo : n:int => olist(int)⟧
let foo = (n) => {
  let n0 = n;
  let n1 = n0 + 1;
  let l2 = ONil;
  let l1 = OCons(n1, l2);
  let l0 = OCons(n0, l1);
  l0
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist02 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val mkOList : lo:int => hi:int => olist(int[v|(lo <= v) & (v < hi)])⟧
let rec mkOList = (lo, hi) => {
  let leq = lo < hi;
  if (leq) {
    let lo1 = lo + 1;
    let tl  = mkOList(lo1, hi);
    OCons(lo, tl)
  } else {
    ONil
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_single00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_tail01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_tuple00 [
	self processString: '
⟦ ⟧




'
]
