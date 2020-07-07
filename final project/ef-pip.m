(load-from model-base_directory pip-arch.m)
(load-from model-base_directory ef.m)


(make-pair digraph-models 'ef-pip)
(send ef-pip build-composition-tree ef-pip (list pip-arch ef))
(send ef-pip set-inf-dig(list (list pip-arch ef) (list ef pip-arch) ) )

(send ef-pip set-int-coup pip-arch ef (list (cons 'out 'in) ) ) 
(send ef-pip set-int-coup ef pip-arch (list (cons 'out 'in) ) ) 
(send ef-pip set-ext-out-coup ef (list (cons 'result 'out)))

(define (sel-pip slst)
	(cond ( (member pip-arch slst) pip-arch)
		( ( member ef slst) ef)
) )
(send ef-pip set-selectfn sel-pip)

(send ef-pip set-priority (list pip-arch ef) )

(mk-ent root-co-ordinators r)
(initialize r c:ef-pip)
(restart r)