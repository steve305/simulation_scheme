(make-pair atomic-models 'tsp)


(send tsp def-state '(job-id
			pt1
			pt2
			pt3
			)
)
(send tsp set-s
	(make-state 'sigma 'inf
		'phase	'passive
		'job-id '()
		'pt1 2
		'pt2 3
		'pt3 4
	)
)
(define (ex-f s e x)
	(case (content-port x)
		('in 
			(case (state-phase s)
				('passive 
					
					(set! (state-job-id s) (content-value x) )
					(hold-in 'busy1 (state-pt1 s) )
					
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
	('busy2
		(make-content 'port 'out1 'value (state-job-id s) )
	)
	('busy3
		(make-content 'port 'out2 'value (state-job-id s) )
	)
	(busy1
		(make-content )
	)
	)
)
(define (int-f s)
	(case (state-phase s)
		('busy1
			(begin
				(hold-in 'busy2 (state-pt2 s) )
			)
		)
		('busy2
			( begin
				(hold-in 'busy3 (state-pt3 s) )
			)
		)
		('busy3
			(passivate)
		)
	)
)

(send tsp set-ext-transfn ex-f)
(send tsp set-int-transfn int-f)
(send tsp set-outputfn out-f)
		