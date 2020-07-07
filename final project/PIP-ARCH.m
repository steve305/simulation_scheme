
   ;;;;;;;;;;;;pip-arch.m;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; The Pipe-line Architecture    ;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



   ;-------------------------------------------------------------
   ; This file contains the construction of the pipeline
   ; architecture  using a digraph-model. The components
   ; are retrieved from prototypes in the model-base.
   ; Components: Three sub-processors are copies of p in file "p.m"
   ;              One co-ordinator : pip-c  defined in "pip-c.m"
   ;-------------------------------------------------------------

   (load-from model-base_directory psm.m)
   (load-from model-base_directory pip-c.m)

   ;; make three copies from original p processor and copy its initial state

   (send psm make-new 'p1)                                        
   (send p1 copy-state psm)

   (send psm make-new 'p2) 
   (send p2 copy-state psm)

   (send psm make-new 'p3)
   (send p3 copy-state psm)
                                                                
   ;;now couple them to the pipeline co-ordinator
  
   (make-pair digraph-models 'pip-arch) 

   ;;composition tree

   (send pip-arch build-composition-tree
                  pip-arch
                  (list pip-c p1 p2 p3))

   ;;influence digraph

   (send pip-arch set-inf-dig (list (list pip-c p1 p2 p3)
                                      (list p1 pip-c)
                                      (list p2 pip-c)
                                      (list p3 pip-c)))

   ;;internal coupling between processors and co-ordinator

   (send pip-arch set-int-coup pip-c p1 (list (cons 'x1 'in)))
   (send pip-arch set-int-coup p1 pip-c (list (cons 'out 'y1)))
   (send pip-arch set-int-coup pip-c p2 (list (cons 'x2 'in)))
   (send pip-arch set-int-coup p2 pip-c (list (cons 'out 'y2)))
   (send pip-arch set-int-coup pip-c p3 (list (cons 'x3 'in)))
   (send pip-arch set-int-coup p3 pip-c (list (cons 'out 'y3)))

   ;; external-input coupling

   (send pip-arch set-ext-inp-coup pip-c (list (cons 'in 'in)))

   ;; external-output coupling                                  

   (send pip-arch set-ext-out-coup pip-c (list (cons 'out 'out)))

   ;; define the select function to avoid  collision when a job
   ;; arrives at the time a processor finishes: processors first
   ;; then co-ordinator

   (define (sel-pip slst)
       (cond ((member p1 slst) p1)
             ((member p2 slst) p2)
             ((member p3 slst) p3)
             ((member pip-c slst) pip-c)
      ))

   (send pip-arch set-selectfn sel-pip)

  ;; equivalently

    (send pip-arch set-priority (list p1 p2 p3 pip-c))

  ;; is shorter and preferable when using flat-devs and deep-devs
