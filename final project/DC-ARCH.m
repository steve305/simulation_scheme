       
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;Contents of file: dc-arch.m ;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   ;; The Module of Divide and Conquer Architecture 
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   ;------------------------------------------------------------- 
   ; This file contains the construction of the divide and conquer 
   ; architecture by using digraph-model. The components 
   ; are retrieved from the models.m defined in model-base. 
   ;; components: One job partition process (p.m) -- p&div. 
   ;              Three sub-processors (p.m) -- p1, p2, p3. 
   ;              One post-compiler (p.m) -- p&cmpl. 
   ;              One co-ordinator (dc-c.m) -- dc-c. 
   ;------------------------------------------------------------- 
    
   ;; get one base processor and one co-ordinator 
   (load-from model-base_directory psm.m)
 (load-from model-base_directory pc.m)
 (load-from model-base_directory pd.m)

   (load-from model-base_directory dc-c.m)
    
   ;; make five copies from the original p processor 
   ; first the pre-job-partition processor 

   (send pd make-new 'p&div) 

   ; and the post-compiler 

   (send pc make-new 'p&cmpl) 
    
   ; three sub-processors 

   (send psm make-new 'p1) 
   (send psm make-new 'p2) 
   (send psm make-new 'p3) 
    
   ;; now couple them together

   (make-pair digraph-models 'dc-arch) 

   ;; composition components 

   (send dc-arch build-composition-tree 
                 dc-arch 
                 (list dc-c p&div p1 p2 p3 p&cmpl) 
   ) 
                                    ;;p&div: partition  processor 
                                    ;;p&cmpl: compiler 
    
   ;; influence digraph 

   (send dc-arch set-inf-dig (list (list dc-c p&div p1 p2 p3 p&cmpl) 
                                   (list p&div dc-c) 
                                   (list p1 dc-c) 
                                   (list p2 dc-c) 
                                   (list p3 dc-c) 
                                   (list p&cmpl dc-c))) 
    
   ;; internal coupling 

   (send dc-arch set-int-coup dc-c p&div (list (cons 'px  'in))) 
   (send dc-arch set-int-coup p&div dc-c (list (cons 'out 'py))) 
   (send dc-arch set-int-coup dc-c p1 (list (cons 'x1  'in))) 
   (send dc-arch set-int-coup p1 dc-c (list (cons 'out 'y1))) 
   (send dc-arch set-int-coup dc-c p2 (list (cons 'x2  'in))) 
   (send dc-arch set-int-coup p2 dc-c (list (cons 'out 'y2))) 
   (send dc-arch set-int-coup dc-c p3 (list (cons 'x3  'in))) 
   (send dc-arch set-int-coup p3 dc-c (list (cons 'out 'y3))) 
   (send dc-arch set-int-coup dc-c p&cmpl (list (cons 'cx  'in))) 
   (send dc-arch set-int-coup p&cmpl dc-c (list (cons 'out 'cy))) 
    
   ;; external-internal coupling 

   (send dc-arch set-ext-inp-coup dc-c (list (cons 'in 'in))) 
    
   ;; internal-external coupling 

   (send dc-arch set-ext-out-coup dc-c (list (cons 'out 'out))) 
    
   ;; define the select function to avoid collision when a job 
   ;; arrives at the same time the processor finishes 

   (define (sel-dcc slst) 
           (cond   ((member p&cmpl slst) p&cmpl) 
                   ((member p1  slst) p1) 
                   ((member p2  slst) p2) 
                   ((member p3  slst) p3) 
                   ((member p&div  slst) p&div) 
                   ((member dc-c slst) dc-c) 
           ) 
   )                      

   (send dc-arch set-selectfn sel-dcc) 

   ;;equivalently, and preferably when flat-devs and deep-devs are used
  
   (send dc-arch set-priority (list p&cmpl p1 p2 p3 p&div dc-c))
