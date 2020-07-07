(make-pair atomic-models 'nep-to)


(send nep-to def-state '(job-id)
)
(send nep-to set-s
	(make-state 'sigma 5
		'phase	'setup
		'job-id '(g1 g2)
	)
)

(define (out-f s)
	(case (state-phase s)
	('setup
		(make-content 'port 'out1 'value 'g1 )
	)
	('busy
		(make-content 'port 'out2 'value 'g2 )
	)
	)
)
(define (int-nep-to s)
	(case (state-phase s)
		('setup
			(begin
				(set! (state-job-id s) '(g2) )
				(set! (state-phase s) 'busy )
			)
		)
		('busy
			(passivate)
		)
	)
)


(send nep-to set-int-transfn int-nep-to)
(send nep-to set-outputfn out-f)
		