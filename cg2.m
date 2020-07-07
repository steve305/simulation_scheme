(make-pair atomic-models 'cg2)


(send cg2 def-state '(pt1
		pt2
		number
			
			)
)
(send cg2 set-s
	(make-state 'sigma 5
		'phase	'active1
		'pt1	5
		'pt2	10
		'number	0
	)
)
(define (ex-f s e x)
	 (case (content-port x)
                      ('stop
			(passivate)
		)
                )
)
(define (out-f s)
	(case (state-phase s)
                      ('active1  (make-content  'port 'out1 'value '(g1)))
		('active2 (make-content 'port 'out2 'value '(g2) ) )
                      (else   (make-content))
                )
)
(define (int-f s)
	 (case (state-phase s)
                      ('active1
			(case (state-number s)
				(0
				(begin
				(set! (state-number s) 1)
				(hold-in 'active1 (state-pt1 s) )
				)
				)
				(1
				(begin
				(set! (state-number s) 0)
				(hold-in 'active2 (state-pt2 s) )
				)
				)
			)
		)
		('active2
			(case (state-number s)
				(0
				(begin
				(set! (state-number s) 1)
				(hold-in 'active2 (state-pt2 s) )
				)
				)
				(1
				(begin
				(set! (state-number s) 0)
				(hold-in 'active1 (state-pt1 s) )
				)
				)
			)
			
		)
                )
)

(send cg2 set-ext-transfn ex-f)
(send cg2 set-int-transfn int-f)
(send cg2 set-outputfn out-f)
		