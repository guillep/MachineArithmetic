Class {
	#name : #SpriteHornPosTest,
	#superclass : #SpriteHornTest,
	#category : #'SpriteLang-Tests-Horn'
}

{ #category : #tests }
SpriteHornPosTest >> provePos: txt [
	self assert: (self verify: txt) equals: #Safe
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc00 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (and
    (and)
    (forall ((VV int) (VV === 10))
     ((Bool true))))
   (forall ((bar int) (bar === (10 + 1)))
    (and
     (and)
     (forall ((VV int) (VV === 0))
      ((Bool true))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc01 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and)
      (forall ((v int) (0 <= v))
       ((Bool true))))
     (forall ((tmp int) (tmp === (x + 1)))
      (and
       (and
        (and)
        (forall ((v int) (v === (x + 1)))
         ((Bool true))))
       (forall ((v int) (v === (tmp + 1)))
        (((0 <= v))))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc02 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and
       (and)
       (forall ((v int) (0 <= v))
        (((0 <= v)))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))
     (and
      (and
       (and)
       (and
        (forall ((v int) (0 <= v))
         ((Bool true)))
        (forall ((_xxx int) (0 <= _xxx))
         (forall ((v int) (v === (_xxx + 1)))
          (((0 <= v)))))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1int00 [
	self provePos: '
(constraint
 (and
  (and)
  (forall ((v1 Int) (v1 === 1))
   (and
    (and)
    (forall ((v2 Int) (v2 === 2))
     (and
      (and
       (and
        (and)
        (forall ((VV Int) (VV === 1))
         ((Bool true))))
       (forall ((VV Int) (VV === 2))
        ((Bool true))))
      (forall ((top Int) (top === (v1 + v2)))
       (and
        (and)
        (forall ((VV Int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1int01 [
	self provePos: '
(constraint
 (and
  (and
   (and
    (and)
    (forall ((VV int) (VV === 1))
     ((Bool true))))
   (forall ((VV int) (VV === 1))
    ((Bool true))))
  (forall ((v1 int) (v1 === (1 + 1)))
   (and
    (and)
    (forall ((v2 int) (v2 === 2))
     (and
      (and
       (and
        (and
         (and)
         (forall ((v int) (v === (1 + 1)))
          ((Bool true))))
        (forall ((VV int) (VV === 2))
         ((Bool true))))
       (forall ((v int) (v === (v1 + v2)))
        (((v === 4)))))
      (forall ((top int) (top === 4))
       (and
        (and)
        (forall ((VV int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L2' }
SpriteHornPosTest >> testL2abs00 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (VV === x))
       ((Bool true))))
     (forall ((VV int) (VV === 0))
      ((Bool true))))
    (forall ((pos bool) (pos <=> (x >= 0)))
     (and
      (forall ((lq_tmpßgrdºº2 bool) (pos))
       (and
        (and)
        (forall ((VV int) (VV === x))
         (((0 <= VV))))))
      (forall ((lq_tmpßgrdºº2 bool) (pos not))
       (and
        (and
         (and
          (and)
          (forall ((VV int) (VV === 0))
           ((Bool true))))
         (forall ((VV int) (VV === x))
          ((Bool true))))
        (forall ((v int) (v === (0 - x)))
         (((0 <= v))))))))))
  (and
   (and)
   (forall ((VV int) (VV === 0))
    ((Bool true))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01 [
	self provePos: '
(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (forall ((b bool) (b))
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (and
     (and
      (forall ((VV int) (and (Bool true) (VV === x)))
       (and))
      (forall ((VV int) (VV === 0))
       (and)))
     (forall ((pos bool) (pos <=> (x >= 0)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
        (and
         (and
          (forall ((VV int) (VV === 0))
           (and))
          (forall ((VV int) (and (Bool true) (VV === x)))
           (and)))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))))
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((VV int) (and (Bool true) (VV === y)))
       (and))
      (forall ((ya int) ($k_ºº1 ya y))
       (and
        (and
         (forall ((VV int) (VV === 0))
          (and))
         (forall ((VVºº0 int) (and ($k_ºº1 VVºº0 y) (VVºº0 === ya)))
          (and)))
        (forall ((ok bool) (ok <=> (0 <= ya)))
         (and
          (forall ((v bool) (and (v <=> (0 <= ya)) (v === ok)))
           ((v)))
          (forall ((VV int) (Bool true))
           (and))))))))
    (forall ((VV int) (VV === 0))
     (and))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01debug [
	self provePos: '
(var $k_ºº1 ((int) (int) (int)))

(constraint
 (and
  (forall ((b bool) (b))
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 10))
     (((VV >= 0)))))
   (and
    (forall ((z int) (Bool true))
     (and
      (and
       (forall ((VV int) (and (Bool true) (VV === z)))
        (and))
       (forall ((r int) ($k_ºº1 r z z))
        (forall ((VVºº0 int) (and ($k_ºº1 VVºº0 z z) (VVºº0 === r)))
         (((VVºº0 >= 0))))))
      (and
       (and
        (forall ((VV int) (Bool true))
         (and))
        (forall ((y int) (Bool true))
         (forall ((v1 int) (v1 >= 0))
          (($k_ºº1 v1 z y)))))
       (forall ((v2 int) (v2 >= 0))
        (and)))))
    (forall ((VV int) (VV === 0))
     (and))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01shorter [
	self provePos: '
(var $k_ºº1 ((int) (int)))

(constraint
  (and
   (forall ((x int) (Bool true))
     (forall ((pos bool) (pos <=> (x >= 0)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))
    (forall ((y int) (Bool true))
      (forall ((ya int) ($k_ºº1 ya y))
        (forall ((ok bool) (ok <=> (0 <= ya)))
          (forall ((v bool) (and (v <=> (0 <= ya)) (v === ok)))
           ((v))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs02debug [
	self provePos: '
(var $k ((int) (int) (int)))

(constraint
 (and
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 10))
     (((VV >= 0)))))
    (forall ((z int) (Bool true))
     (and
      (and
       (forall ((r int) ($k r z z))
        (forall ((VVºº0 int) (and ($k VVºº0 z z) (VVºº0 === r)))
         (((VVºº0 >= 0))))))
        (forall ((y int) (Bool true))
         (forall ((v1 int) (v1 >= 0))
          (($k v1 z y)))))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3sum01 [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))

(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (and
   (forall ((n int) (Bool true))
    (and
     (forall ((cond bool) (cond <=> (n <= 0)))
      (and
       (forall ((lq_tmpßgrdºº4 bool) (cond))
        (forall ((VV int) (VV === 0)) 
         (($k_ºº1 VV n))))
       (forall ((lq_tmpßgrdºº4 bool) (cond not))
        (and
         (forall ((n1 int) (n1 === (n - 1)))
          (and
           (forall ((t1 int) ($k_ºº1 t1 n1))
            (and
             (forall ((v int) (v === (n + t1)))
              (($k_ºº1 v n))))))))))))) 
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((res int) ($k_ºº1 res y))
       (and
        (forall ((ok bool) (ok <=> (0 <= res)))
         (and
          (forall ((v bool) (and (v <=> (0 <= res)) (v === ok)))
           ((v))) 
           )))))))
    (and
     (forall ((y int) (Bool true))
      (and
       (forall ((res int) ($k_ºº1 res y))
        (and
         (forall ((ok bool) (ok <=> (y <= res)))
          (and
           (forall ((v bool) (and (v <=> (y <= res)) (v === ok)))
            ((v))) 
            ))))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3sum01α [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))

(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (and
   (forall ((n int) (Bool true))
    (and
     (forall ((cond bool) (cond <=> (n <= 0)))
      (and
       (forall ((lq_tmpßgrdºº4 bool) (cond))
        (forall ((VV int) (VV === 0)) 
         (($k_ºº1 VV n))))
       (forall ((lq_tmpßgrdºº4 bool) (cond not))
        (and
         (forall ((n1 int) (n1 === (n - 1)))
          (and
           (forall ((t1 int) ($k_ºº1 t1 n1))
            (and
             (forall ((v int) (v === (n + t1)))
              (($k_ºº1 v n))))))))))))) 
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((res int) ($k_ºº1 res y))
       (and
        (forall ((ok bool) (ok <=> (0 <= res)))
         (and
          (forall ((w bool) (and (w <=> (0 <= res)) (w === ok)))
           ((w))) 
           )))))))
    (and
     (forall ((y int) (Bool true))
      (and
       (forall ((res int) ($k_ºº1 res y))
        (and
         (forall ((ok bool) (ok <=> (y <= res)))
          (and
           (forall ((w bool) (and (w <=> (y <= res)) (w === ok)))
            ((w))) 
            ))))))))))
'

]

{ #category : #'tests-L4' }
SpriteHornPosTest >> testL4foldn00 [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(var $k_ºº3 ((int) (int)))
(var $k_ºº1 ((`a) (bool) (int) (int) (`a) (`a) (int)))

(constraint
 (and
  (forall ((acc `a) (Bool true))
   (forall ((i int) (0 <= i))
    (forall ((n int) (i <= n))
     (and
      (forall ((leq bool) (leq <=> (i < n)))
       (and
        (forall ((lq_tmpßgrdºº6 bool) (leq))
         (and
          (forall ((ip int) (ip === (i + 1)))
           (and
             (forall ((v int) (and (0 <= v) (v === i)))
              (((0 <= v))))
            (forall ((accp `a) (Bool true))
             (and
              (and
               (and
                (and
                  (forall ((_ `a) (and ($k_ºº1 _ leq n ip accp acc i) (Bool true)))
                    (forall ((_ int) (0 <= _))
                     (forall ((VV `a) (Bool true))
                        (($k_ºº1 VV leq n ip accp acc i)))))
                 (forall ((VV `a)  (VV === accp))
                  (($k_ºº1 VV leq n ip accp acc i))))
                (forall ((v int) (and (v === (i + 1)) (v === ip)))
                 (((0 <= v)))))
               (forall ((v int) (and (i <= v) (v === n)))
                (((ip <= v)))))))))))))))))
  (and
   (forall ((x int) (Bool true))
    (forall ((y int) (Bool true))
      (forall ((v int) (v === (x + y)))
       (((v === (x + y)))))))
    (forall ((m int) (0 <= m))
     (and
      (and
       (and
        (and
          (forall ((_ int) (and ($k_ºº3 _ m) (Bool true)))
            (forall ((_ int) (0 <= _))
             (forall ((v int) (v === (_ + _)))
              (($k_ºº3 v m)))))
         (forall ((VV int) (VV === 0))
          (($k_ºº3 VV m))))
        (forall ((VV int) (VV === 0))
         (((0 <= VV)))))
       (forall ((v int) (and (0 <= v) (v === m)))
        (((0 <= v)))))
      (forall ((VVºº2 int) (and ($k_ºº3 VVºº2 m) (Bool true)))
       (((0 <= VVºº2)))))))))
'

]

{ #category : #'tests-L4' }
SpriteHornPosTest >> testL4id00 [
	self provePos: '
(var $k ((int) (int)))

(constraint
   (forall ((y int) (0 <= y))
    (and
     (forall ((v int) (and ((0 <= v)) ((v === y))))
        (($k v y)))
     (forall ((res int)  ($k res y))
      (forall ((z int) (and (and ($k z y) ((Bool true))) ((z === res))))
       ((0 <= z)))))))
'

]

{ #category : #'tests-L4' }
SpriteHornPosTest >> testL4id00s [
	self provePos: '
(var $k ((int) (int)))

(constraint
   (forall ((y int) (0 <= y))
    (and
     (forall ((v int) (and ((0 <= v)) ((v === y))))
        (($k v y)))
     (forall ((res int)  ($k res y))
      (forall ((VVºº0 int) (and ($k VVºº0 y) ((VVºº0 === res))))
       ((0 <= VVºº0)))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5MonoCons [
	"Like cons00 but with monomorphic (List Int)."
	self provePos: '
(var $k3 ((int) ((`l int)) (int)))
(var $k1 ((int) (int)))

(constant len (func(0 , [(`l int); int])))

(constraint
  (forall ((x int) (Bool true))
   (forall ((t (`l int)) ( (len value: t) === 0))
    (and
      (forall ((V int) (V === x))
       (($k3 V t x)))
       (forall ((VV int)  ($k1 VV x))
        (($k3 VV t x)))
      (forall ((v (`l int)) ((len value: v) === (1 + (len value: t))))
       ((((len value: v) === 1))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5cons00 [
	self provePos: '
(var $k3 ((`a) ((`l `a)) (`a)))
(var $k1 ((`a) (`a)))

(constant len (func(1 , [(`l @(0)); int])))

(constraint
  (forall ((x `a) (Bool true))
   (forall ((t (`l `a)) ((len value: t) === 0))
     (and
      (forall ((VV `a) (VV === x))
       (($k3 VV t x)))
      (forall ((VV0 `a)  ($k1 VV0 x))
        (($k3 VV0 a x)))
      (forall ((v (`l `a)) ((len value: v) === (1 + (len value: t))))
       ((((len value: v) === 1))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5nil00 [
	self provePos: '
(constant len (func(1 , [(`l @(0)); int])))

(constraint
  (forall ((x `a) (Bool true))
   (forall ((t (`l `a)) ((len value: t) === 0))
     (forall ((v (`l `a)) (((len value: v) === 0) & (v === t)))
      ((((len value: v) === 0)))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5olist00 [
	self provePos: '
(var $k ((int) (int) ((`o int))))

(constraint
 (and
  (forall ((apple int) (Bool true))
   (forall ((horse (`o int)) (Bool true))
    (and
     (and
      (forall ((VV int) (VV === apple))
       (($k VV apple horse)))
      (and
       (forall ((v int) (apple < v))
        (and
         (($k v apple horse))
         (((apple < v))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5olist01 [
	self provePos: '
(var $k_5 ((int) ((`o int)) ((`o int)) (int) (int) (int)))
(var $k_3 ((int) ((`o int)) (int) (int) (int)))
(var $k_1 ((int) (int) (int) (int)))

(constraint
  (forall ((n int) (Bool true))
   (forall ((n0 int) (n0 === n))
     (forall ((n1 int) (n1 === (n0 + 1)))
      (forall ((l2 (`o int)) (Bool true))
       (and
        (and
         (forall ((v int) ((v === (n0 + 1)) & (v === n1)))
          (($k_3 v l2 n0 n n1)))
          (forall ((VV0 int) (and ($k_1 VV0 n0 n n1) (Bool true)))
           (and
            (($k_3 VV0 l2 n0 n n1))
            (((n1 < VV0))))))
        (forall ((l1 (`o int)) (Bool true))
          (and
           (forall ((VV int) (and (VV === n) (VV === n0)))
            (($k_5 VV l1 l2 n0 n n1)))
           (forall ((VV2 int) (and ($k_3 VV2 l2 n0 n n1) (Bool true)))
             (and
              (($k_5 VV2 l1 l2 n0 n n1))
              (((n0 < VV2)))))))))))))
'

]
