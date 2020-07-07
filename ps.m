(make-pair atomic-models 'ps)


(send ps def-state '(job-id
			stack
			p.t
			
			)
)
(send ps set-s
	(make-state 'sigma 'inf
		'phase	'passive
		'job-id '()
		'stack '()
		'p.t 10
	)
)
(define (ex-f s e x)
	 (case (content-port x)
                      ('in (case (state-phase s)
                                 ('passive
                                        (set! (state-job-id s) (content-value x))
                                        (hold-in 'busy (state-p.t s))
                                 )
                                 ('busy 
                                        (set! (state-stack s) 
                                             (append (list (content-value x))  (state-stack s) )
                                        )
                                        (continue)
                                 )
                           )
                      )
                )
)
(define (out-f s)
	(case (state-phase s)
                      ('busy  (make-content  'port 'out 'value (state-job-id s)))
                      (else   (make-content))
                )
)
(define (int-f s)
	 (case (state-phase s)
                      ('busy (if (null? (state-stack s))
                                 (passivate)
                                 (begin (set! (state-job-id s) (car(state-stack s)))
                                        (set! (state-stack s)  (cdr(state-stack s)))
                                        (hold-in 'busy (state-p.t s))
                                 )
                             )
                      )
                )
)

(send ps set-ext-transfn ex-f)
(send ps set-int-transfn int-f)
(send ps set-outputfn out-f)
		