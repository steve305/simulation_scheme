(make-pair atomic-models 'selp)


(send selp def-state '(job-id
			queue
			processing-time
			
			)
)
(send selp set-s
	(make-state 'sigma 'inf
		'phase	'passive
		'job-id '()
		'queue '()
		'processing-time	5
	)
)
(define (ex-f s e x)
	(if (< 9 (content-value x) )
	 (case (content-port x)
                      ('in (case (state-phase s)
                                 ('passive
                                        (set! (state-job-id s) (content-value x))
                                        (hold-in 'busy (state-processing-time s))
                                 )
                                 ('busy 
                                        (set! (state-queue s) 
                                             (append  (state-queue s) (list (content-value x)))
                                        )
                                        (continue)
                                 )
                           )
                      )
                )
	(continue)
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
                      ('busy (if (null? (state-queue s))
                                 (passivate)
                                 (begin (set! (state-job-id s) (car(state-queue s)))
                                        (set! (state-queue s)  (cdr(state-queue s)))
                                        (hold-in 'busy (state-processing-time s))
                                 )
                             )
                      )
                )
)

(send selp set-ext-transfn ex-f)
(send selp set-int-transfn int-f)
(send selp set-outputfn out-f)
		