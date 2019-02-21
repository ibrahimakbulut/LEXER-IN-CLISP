
(defun lexer(file)

(setq KEYWORDS '( "and" "or" "not" "equal" "append" "concat"
"set" "deffun" "for" "while" "if" "exit") )
(setq OPERATORS '( "+" "-" "*" "(" ")" "**"))
(setq result_list '())
(setq temp_list '())

(defun from-list-to-string (listt)
    (format nil "~{~A~}" listt))


(let ((in (open file :if-does-not-exist nil)))
  (when in
    (loop for line = (read-char in nil)
         while line do (setq temp_list (push line temp_list))) ;openin file and read chararacter by character
    (close in)))
	(setq temp_list (reverse temp_list)) 


(loop 

(if (or (and (< (char-code (car temp_list)) 123) (> (char-code (car temp_list)) 96) ) (and (< (char-code (car temp_list)) 91) (> (char-code (car temp_list)) 64) ) ) ;if firs char is a letter

	(progn 
		(setq word '())
		(loop 
			(if (or (and (< (char-code (car temp_list)) 123) (> (char-code (car temp_list)) 96) ) (and (< (char-code (car temp_list)) 91) (> (char-code (car temp_list)) 64) ) ) ;take characters until non letter character
				(push  (car temp_list) word)
			()
			)

   			(when (or (equal  (char-code (car temp_list)) 32) (and (< (char-code (car temp_list)) 58) (> (char-code (car temp_list)) 47)) (and  (not (or (and (< (char-code (car temp_list)) 123) (> (char-code (car temp_list)) 96) ) (and (< (char-code (car temp_list)) 91) (> (char-code (car temp_list)) 64) ) ))  (not (and (< (char-code (car temp_list)) 58) (> (char-code (car temp_list)) 47) )))) (return (cdr temp_list)))
    		(setq temp_list (cdr temp_list))

		)
		(setq word (reverse word))
		(setq keyword_temp KEYWORDS)
		(setq y 0)
		(loop
			(if (equal (car keyword_temp) (from-list-to-string word))(progn
			(setq result_list  (append result_list (list (cons "KEYWORD" (list (from-list-to-string word))) ) ) ) ;is word a keyword not identifier 
			(setq y 1))

			)
			(when (or (null (cdr keyword_temp) ) (equal (car keyword_temp) (from-list-to-string word))) (return nil))
			(setq keyword_temp (cdr keyword_temp))
		)	
			(if (equal y 0)
			(setq result_list  (append result_list (list (cons "identifier" (list (from-list-to-string word))) ) ) )
			)	
	)
		
)

(if  (and (< (char-code (car temp_list)) 58) (> (char-code (car temp_list)) 47) ) ;if firs character is digit 
	(progn
		(setq number '())
		(loop 
			(if  (and (< (char-code (car temp_list)) 58) (> (char-code (car temp_list)) 47) ) ; take characters until non-digit character
				(push  (car temp_list) number)
			() 
			)
   			(when (or (equal  (char-code (car temp_list)) 32) (or (and (< (char-code (car temp_list)) 123) (> (char-code (car temp_list)) 96) ) (and (< (char-code (car temp_list)) 91) (> (char-code (car temp_list)) 64) ) ) ) (return (cdr temp_list)))
    		(setq temp_list (cdr temp_list))
		)

		(setq number (reverse number)) 
(setq result_list  (append result_list (list (cons "int" (list (from-list-to-string number))) ) ) ) ;int and number added lexer output list

	)
)
(if (and   (not (or (and (< (char-code (car temp_list)) 123) (> (char-code (car temp_list)) 96) ) (and (< (char-code (car temp_list)) 91) (> (char-code (car temp_list)) 64) ) )) (not (equal (char-code (car temp_list)) 10) )  (not (and (< (char-code (car temp_list)) 58) (> (char-code (car temp_list)) 47) )) (not (equal (char-code (car temp_list)) 32)))
	(progn
		(setq operator_temp '())
		(push  (car temp_list) operator_temp)
	)
)
;if character is operator 
(setq result_list  (append result_list (list (cons "operator" (list (from-list-to-string operator_temp))) ) ) )
   (when (null  (cdr temp_list) ) (return result_list))
       (setq temp_list (cdr temp_list))

)
(write result_list)
)
