
         
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

   (make-pair atomic-models 'pc)

   ;;;;;;;; set up additional variables job-id and processing-time

   (send pc def-state
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

   (send pc set-s
              (make-state 'sigma     'inf
                          'phase     'passive
                          'pl_list    '()   
		'job_id  '()
		'first	 '()
		'second	'()
		'third	'()
                         

              )
   )


   ;;;;;;;; define the external transition function

   (define (ex-f s e x)
                 (case (content-port x)
		 ('in (case (state-phase s)
                       ('passive (set! (state-job_id s) (car (content-value x) ) )
			(set! (state-first s) (cadr (content-value x) ) )
			(set! (state-second s) (caddr (content-value x) ) )
			(set! (state-third s) (cadddr (content-value x) ) )
		
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
	( set! (state-pl_list s) (append (state-pl_list s) (state-first s) ) )
	( set! (state-pl_list s) (append (state-pl_list s) (state-second s) ) )
	( set! (state-pl_list s) (append (state-pl_list s) (state-third s) ) )
	
         (make-content 'port 'out 'value (append (list(state-job_id s) ) (list(state-pl_list s) )))
       )
     (else 
	(continue)
)
     )
   )


   ;;;;;;;; assignment to the model

   (send pc set-ext-transfn ex-f)
   (send pc set-int-transfn in-f)
   (send pc set-outputfn out-f)

