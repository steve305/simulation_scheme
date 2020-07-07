(load-from model-base_directory mul-arch.m)
(load-from model-base_directory ef.m)


(make-pair digraph-models 'ef-mul)
(send ef-mul build-composition-tree ef-mul (list mul-arch ef))
(send ef-mul set-inf-dig(list (list mul-arch ef) (list ef mul-arch) ) )

(send ef-mul set-int-coup mul-arch ef (list (cons 'out 'in) ) ) 
(send ef-mul set-int-coup ef mul-arch (list (cons 'out 'in) ) ) 
(send ef-mul set-ext-out-coup ef (list (cons 'result 'out)))

(define (sel-mul slst)
	(cond ( (member mul-arch slst) mul-arch)
		( ( member ef slst) ef)
) )
(send ef-mul set-selectfn sel-mul)

(send ef-mul set-priority (list mul-arch ef) )

(mk-ent root-co-ordinators r)
(initialize r c:ef-mul)
(restart r)