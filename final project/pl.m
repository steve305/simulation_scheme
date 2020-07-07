
         
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

   (make-pair atomic-models 'pl)

   ;;;;;;;; set up additional variables job-id and processing-time

   (send pl def-state
              '(
               ;;;state-variables:
 		pl_list ;
		job_id ;
                
               )
   )


   ;;;;;;;; initialize variables

   (send pl set-s
              (make-state 'sigma     'inf
                          'phase     'passive
                          'pl_list    '()   
		'job_id  '()
                         

              )
   )


   ;;;;;;;; define the external transition function

   (define (ex-f s e x)
                 (case (content-port x)
		 ('in (case (state-phase s)
                       ('passive (set! (state-pl_list s) (cadr (content-value x) ))
			(set! (state-job_id s) (car (content-value x) ) )
                                 (hold-in 'busy (truncate (unifrm 6 10 1)))
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
(set! (state-pl_list s)	( map (lambda(x) (if (= 0 (remainder x 2) ) (+ x 1) x) ) (state-pl_list s) ))
           (make-content 'port 'out 'value (append (list(state-job_id s) ) (list(state-pl_list s)) ))
       )
     (else 
	(continue)
)
     )
   )


   ;;;;;;;; assignment to the model

   (send pl set-ext-transfn ex-f)
   (send pl set-int-transfn in-f)
   (send pl set-outputfn out-f)

