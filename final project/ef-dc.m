(load-from model-base_directory DC-ARCH.m)
(load-from model-base_directory ef.m)


(make-pair digraph-models 'ef-dc)
(send ef-dc build-composition-tree ef-dc (list dc-arch ef))
(send ef-dc set-inf-dig(list (list dc-arch ef) (list ef dc-arch) ) )

(send ef-dc set-int-coup dc-arch ef (list (cons 'out 'in) ) ) 
(send ef-dc set-int-coup ef dc-arch (list (cons 'out 'in) ) ) 
(send ef-dc set-ext-out-coup ef (list (cons 'result 'out)))

(define (sel-dc slst)
	(cond ( (member dc-arch slst) dc-arch)
		( ( member ef slst) ef)
) )
(send ef-dc set-selectfn sel-dc)

(send ef-dc set-priority (list ef-dc ef) )

(mk-ent root-co-ordinators r)
(initialize r c:ef-dc)
(restart r)