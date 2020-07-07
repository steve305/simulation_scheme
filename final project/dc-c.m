
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; The content of dc-c.m ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;; Divide and Conquer Co-ordinator ;;;;;;;;;;;;;;;;;;;;;;;;;


   ;-------------------------------------------------------------
   ; This file contains the definition of the co-ordinator in
   ; divide and conquer architecture.
   ;-------------------------------------------------------------
   ; It should perform following tasks:
   ; 1) Gets a problem from input and sends the problem to problem-partitioner
   ; 2) When the divided problem is sent back, decides whether the
   ; sub-processors are ALL available. If they are, the sub-problems
   ; will be send to all sub-processors. If not, problem is lost.
   ; 3) After collecting all the returned results from
   ; sub-processors, sends the returned partial results to
   ; post-compiler.
   ; 4) Gets the final result from compiler and sends
   ; it to output.
   ;-------------------------------------------------------------

   ;; make a pair for the co-ordinator in divide and conquer module


   (make-pair atomic-models 'dc-c)

   (send dc-c def-state '(
                          p-cnt     ;; number of partial solutions received
                          out-port  ;; destination for next output
                          job-id
		first
		second
		third
		pl_list
                          ))


   ;; initialize the states of this module
   (send dc-c set-s (make-state 'sigma      'inf
                                'phase      'passive
                                'p-cnt      3
                                'out-port   '()
                                'job-id     '()
		'first '()
		'second '()
		'third '()
		'pl_list '()
   )                 )

   ;;;;;;;; Definition of divide and conquer co-ordinator

   ;; external transition function

   (define (ex-dc s e x)
           (set! (state-out-port s) '())
	 (set! (state-job-id s) (car (content-value  x ) ))
	
           (case (content-port x)

           ; case 1. arrival of a problem

             ('in
             ; Always send to partition processor
               (set! (state-out-port s) 'px)
	(set! (state-pl_list s) (cadr (content-value x) ))
             )

           ;case 2. input from partition processor

             ('py  (set! (state-out-port s) 'xin)
		(set! (state-first s) (cadr (content-value x) ) )
		(set! (state-second s) (caddr (content-value x) ) )
		(set! (state-third s) (cadddr (content-value x) ) )
)

           ;case 3. input from partial solution processors

             ('y1  (set! (state-p-cnt s) (1+ (state-p-cnt s)))
		(set! (state-first s) (cadr (content-value x) ) )
                          (when (= (state-p-cnt s) 3)
                                 ; send the partial results to compiler
                                 (set! (state-out-port s) 'cx)
             )            )   
	  ('y2  (set! (state-p-cnt s) (1+ (state-p-cnt s)))
		(set! (state-second s) (cadr (content-value x) ) )
                          (when (= (state-p-cnt s) 3)
                                 ; send the partial results to compiler
                                 (set! (state-out-port s) 'cx)
             )            )   
	  ('y3  (set! (state-p-cnt s) (1+ (state-p-cnt s)))
		(set! (state-third s) (cadr (content-value x) ) )
                          (when (= (state-p-cnt s) 3)
                                 ; send the partial results to compiler
                                 (set! (state-out-port s) 'cx)
             )            )   
           ;case 4. input from the post compiler

             ('cy  (set! (state-out-port s) 'out))
		(set! (state-pl_list s) (cdr (content-value x)))

           ) ; end of case  
           (hold-in 'busy 0)
   )         ; end of ext-transition function definition



   ;;;;;;;; output function

   (define (out-dc s)
       (case (state-phase s)
         ('busy
           (case (state-out-port s)
                 ('xin    ;;; check whether the processors are all free
                     (if (= (state-p-cnt s) 3)
                       (begin
                          (set! (state-p-cnt s) 0)
                           ;; send to three processors at the same time
                            (list
                             (make-content 'port 'x1  'value (append (list(state-job-id s) ) (list(state-first s)) ))
                             (make-content 'port 'x2  'value (append (list(state-job-id s) ) (list(state-second s)) ))
                             (make-content 'port 'x3  'value (append (list(state-job-id s) ) (list(state-third s) )))
		)
                                                    
                       ); else send no partial jobs to processors
                       (make-content)
                     )
                  )
              ('px  (make-content 'port (state-out-port s) 'value (append (list(state-job-id s) ) (list(state-pl_list s) ))) )
	('cx
		   (make-content 'port (state-out-port s) 'value (append (append (append (list(state-job-id s)) (list(state-first s)) ) (list(state-second s)))  (list(state-third s)))  ) 
	)
	('out
		 (make-content   'port 'out 'value
                                       (append (list(state-job-id s) ) (list(state-pl_list s))) )
	)
                 (else (make-content)) ; no valid output to be made
   )   ) ) )

   ;;;;;;;; internal transition function

   (define (in-dc s)
     (case (state-phase s)
       ('busy
           (passivate)
   ) ) )


   ;;;;;;;; assignment to the  model

   (send dc-c set-ext-transfn ex-dc)
   (send dc-c set-int-transfn in-dc)
   (send dc-c set-outputfn out-dc)

