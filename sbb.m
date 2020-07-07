(make-pair atomic-models 'sbb)
(define (my-and a b)
 (if a b a)
)
(define (logical-and a b)
	(if a
	(if b
		#t
		#f)
	#f)
)

(send sbb def-state '(ball
			strike
			out
			point
			)
)
(send sbb set-s
	(make-state 'sigma 'inf
		'phase	'none
		'ball	0
		'strike	0
		'out	0
		'point	0
	)
)
(define (ex-f s e x)
(let ( (p (random 100) ) )
	(case (state-phase s)
	('passive
		(continue)
	)
	)
	(case (content-port x)
	('fiz
		(if (< p 20) 
		(begin
			(if (= 2 (state-strike s ) )
				(begin
				 (if (= 2 (state-out s) )
					(passivate)
					(begin
					(set! (state-out s) (+ 1 (state-out s) ) )
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					)

				)
				)
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
			)
		)
		)
		(if (logical-and (< p 45) (>= p 20) )
			(begin
			(if (= 2 (state-strike s ) )
					 (set! (state-strike s) (state-strike s)  )
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
			)
			)
		)
		(if (logical-and (< p 60) (>= p 45) )
		(begin
			(if (= 2 (state-out s ) )
					 (passivate )
				(begin
				(set! (state-strike s) 0)
				(set! (state-ball s) 0)
				 (set! (state-out s) (+ 1 (state-out s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 75) (>= p 60) )
		(begin
			(case (state-phase s)
					('passive
						(continue)
					)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) '1st)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) '1st-2nd)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) '1st-2nd)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) '1st-3rd)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) 'full)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) '1st-2nd)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) '1st-3rd)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) 'full)
					)
					
				)
		)
		)
		(if (logical-and (< p 80) (>= p 75) )
		(begin
			(case (state-phase s)
					('passive
						(continue)
					)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) '2nd)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-phase s) '1st-3rd)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) '2nd)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) '2nd)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) '2nd-3rd)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) '2nd-3rd)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(set! (state-phase s) '1st-3rd)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(set! (state-phase s) '2nd-3rd)
					)
					
				)


		)
		)
		
		(if (logical-and (< p 100) (>= p 80) )
		(begin
			(case (state-phase s)
					('passive
						(continue)
					)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(set! (state-phase s) 'none)
					
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 4 (state-point s) ) )
					(set! (state-phase s) 'none)
					)
					
				)
		)
		)
	)
	('siz
		(if (< p 10) 
		(begin
			(if (= 2 (state-strike s ) )
				(begin
				 (if (= 2 (state-out s) )
					(passivate)
					(begin
					(set! (state-out s) (+ 1 (state-out s) ) )
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					)

				)
				)
				(begin
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 30) (>= p 10) )
		(begin
			(if (= 2 (state-strike s ) )
				(begin
					 (set! (state-strike s) (state-strike s)  )
				)
				(begin
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 50) (>= p 30) )
		(begin
			(if (= 2 (state-out s ) )
				(begin
					 (passivate )
				)
				(begin
				(set! (state-strike s) 0)
				(set! (state-ball s) 0)
				 (set! (state-out s) (+ 1 (state-out s) ) )
				)
				
			)
		)
		)
		
		(if (logical-and (< p 70) (>= p 50) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in 'full 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					
					(hold-in 'full 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					
					(hold-in 'full 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'full 'inf)
					)
					
				)
		)
		)
		(if (logical-and (< p 80) (>= p 70) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '2nd 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					
				)


		)
		)
		(if (logical-and (< p 90) (>= p 80) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '3rd 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					
				)
		)
		)
		(if (logical-and (< p 100) (>= p 90) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 4 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					
				)
		)
		)
	)
	('foz
		(if (< p 10) 
		(begin
			(if (= 2 (state-strike s ) )
				(begin
				 (if (= 2 (state-out s) )
					(passivate)
					(begin
					(set! (state-out s) (+ 1 (state-out s) ) )
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					)

				)
				)
				(begin
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
				)
				
			)
		)
			
		)
		(if (logical-and (< p 40) (>= p 10) )
		(begin
			(if (= 2 (state-strike s ) )
				(begin
					 (set! (state-strike s) (state-strike s)  )
				)
				(begin
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 70) (>= p 40) )
		(begin
			(if (= 2 (state-out s ) )
				(begin
					 (passivate )
				)
				(begin
				(set! (state-strike s) 0)
				(set! (state-ball s) 0)
				 (set! (state-out s) (+ 1 (state-out s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 80) (>= p 70) )
		(begin
			(if (= 3 (state-ball s ) )
				(begin
					(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in 'full 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-2nd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'full 'inf)
					)
					
				)
			))
				(begin
				 (set! (state-ball s) (+ 1 (state-ball s) ) )
				)
				)
				
		)
		(if (logical-and (< p 90) (>= p 80) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in 'full 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-2nd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'full 'inf)
					)
					
				)
		)
		)
		(if (logical-and (< p 95) (>= p 90) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '2nd 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '1st-3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					
				)


		)
		)
		(if (logical-and (< p 100) (>= p 95) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 4 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					
				)
		)
		)

	)
	('soz
		(if (< p 5) 
		(begin
			(if (= 2 (state-strike s ) )
				(begin
				 (if (= 2 (state-out s) )
					(passivate)
					(begin
					(set! (state-out s) (+ 1 (state-out s) ) )
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					)

				)
				)
				(begin
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 10) (>= p 5) )
		(begin
			(if (= 2 (state-strike s ) )
				(begin
					 (set! (state-strike s) (state-strike s)  )
				)
				(begin
				 (set! (state-strike s) (+ 1 (state-strike s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 30) (>= p 10) )
		(begin
			(if (= 2 (state-out s ) )
				(begin
					 (passivate )
				)
				(begin
				(set! (state-strike s) 0)
				(set! (state-ball s) 0)
				 (set! (state-out s) (+ 1 (state-out s) ) )
				)
				
			)
		)
		)
		(if (logical-and (< p 60) (>= p 30) )
		(begin
			(if (= 3 (state-ball s ) )
				(begin
					(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in 'full 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-2nd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'full 'inf)
					)
					
				)
			))
				(begin
				 (set! (state-ball s) (+ 1 (state-ball s) ) )
				)
				
				
		)
		)
		(if (logical-and (< p 75) (>= p 60) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in 'full 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-2nd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '1st-3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'full 'inf)
					)
					
				)
		)
		)
		(if (logical-and (< p 85) (>= p 75) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '2nd 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '1st-3rd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '1st-3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '2nd-3rd 'inf)
					)
					
				)


		)
		)
		(if (logical-and (< p 90) (>= p 85) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(hold-in '3rd 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in '3rd 'inf)
					)
					
				)
		)
		)
		(if (logical-and (< p 100) (>= p 90) )
		(begin
			(case (state-phase s)
					('none
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 1 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('1st
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 2 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('1st-2nd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					
					)
					('1st-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('2nd-3rd
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 3 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					('full
					(set! (state-strike s) 0)
					(set! (state-ball s) 0)
					(set! (state-point s) (+ 4 (state-point s) ) )
					(hold-in 'none 'inf)
					)
					
				)
		)
		)
	)
	)
)
	
	
	
)
(define (out-f s)
	(case (state-phase s)
	('passive
	(make-content 'port 'out 'value (state-point s) )
	)
	(else
	(make-content)
	)
	)
)


(send sbb set-ext-transfn ex-f)

(send sbb set-outputfn out-f)
		
