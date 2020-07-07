
         
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Content of the simple processor definition file p.m;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ;-------------------------------------------------------------
   ; This file contains the definition of a simple processor without
   ; buffering capability
   ;-------------------------------------------------------------
   ; It performs following tasks:
   ; Gets a job from input and sends the job to the output after
   ; its processing time.
   ;-------------------------------------------------------------


   ;;;;;;;; make a pair for the processor and its simulator

   (make-pair atomic-models 'pd)

   ;;;;;;;; set up additional variables job-id and processing-time

   (send pd def-state
              '(
               ;;;state-variables:
 		pl_list ;
		job_id ;
		first
		second
		third
                
               )
   )


   ;;;;;;;; initialize variables

   (send pd set-s
              (make-state 'sigma     'inf
                          'phase     'passive
                          'pl_list    '()   
		'job_id  '()
		'first '()
		'second	'()
		'third	'()
                         

              )
   )


   ;;;;;;;; define the external transition function

   (define (ex-f s e x)
                 (case (content-port x)
		 ('in (case (state-phase s)
                       ('passive (set! (state-pl_list s) (cadr (content-value x) ))
			(set! (state-job_id s) (car (content-value x) ) )
                                 (hold-in 'busy (truncate (unifrm 2 4 1)))
                       )
                       ('busy (continue))
                      	 )
                 )
          )
   )

   ;;;;;;;; define the internal transition function

   (define (in-f s)
     (case (state-phase s)
       ('busy   
		(passivate)
	)
   )
 )


   ;;;;;;;; define the output function

   (define (out-f s)
     (case (state-phase s)
       ('busy
	(set! (state-first s) (cons (car (state-pl_list s) ) '() ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-first s) (cons (car (state-pl_list s) ) (state-first s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-first s) (cons (car (state-pl_list s) ) (state-first s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-first s) (cons (car (state-pl_list s) ) (state-first s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-first s) (cons (car (state-pl_list s) ) (state-first s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))

	(set! (state-second s) (cons (car (state-pl_list s) ) '() ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-second s) (cons (car (state-pl_list s) ) (state-second s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-second s) (cons (car (state-pl_list s) ) (state-second s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-second s) (cons (car (state-pl_list s) ) (state-second s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-second s) (cons (car (state-pl_list s) ) (state-second s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))

	(set! (state-third s) (cons (car (state-pl_list s) ) '() ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-third s) (cons (car (state-pl_list s) ) (state-third s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-third s) (cons (car (state-pl_list s) ) (state-third s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-third s) (cons (car (state-pl_list s) ) (state-third s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-third s) (cons (car (state-pl_list s) ) (state-third s) ) )
	(set! (state-pl_list s) (cdr (state-pl_list s) ))
	(set! (state-first s) (reverse (state-first s) ) )
	(set! (state-second s) (reverse (state-second s) ) )
	(set! (state-third s) (reverse (state-third s) ) )
           (make-content 'port 'out 'value (append (append (append (list(state-job_id s)) (list(state-first s))) (list(state-second s)))  (list(state-third s)))  )
       )
     (else 
	(continue)
)
     )
   )


   ;;;;;;;; assignment to the model

   (send pd set-ext-transfn ex-f)
   (send pd set-int-transfn in-f)
   (send pd set-outputfn out-f)

