(make-pair atomic-models 'io)


(send io def-state '(job-id
			
			)
)
(send io set-s
	(make-state 'sigma 'inf
		'phase	'passive
		'job-id	'()
	)
)
(define (ex-f s e x)
	 (case (content-port x)
                      ('in (case (state-phase s)
                                 ('passive
                                        (set! (state-job-id s) (content-value x))
                                        (hold-in 'temporary 0)
                                 )
                                 (else 
                                        (continue)
                                 )
                           )
                      )
                )
)
(define (out-f s)
	(case (state-phase s)
                      ('temporary  (make-content  'port 'out_start 'value (state-job-id s)))
		('busy (make-content 'port 'out_end 'value (state-job-id s) ) )
                      (else   (make-content))
                )
)
(define (int-f s)
	 (case (state-phase s)
                      ('temporary
			(hold-in 'busy 10)
		)
		('busy
			(passivate)
		)
                )
)

(send io set-ext-transfn ex-f)
(send io set-int-transfn int-f)
(send io set-outputfn out-f)
		