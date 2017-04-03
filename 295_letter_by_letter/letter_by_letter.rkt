#lang racket

(println "Hello World!")

(substring "asdf" 0 3)

(define str1 "asdf test hello")
(define str2 "this is a test.")
(for/list ([i (+ 1 (string-length str1))])
  (string-append
   (substring str2 0 i)
   (substring str1 i)
   ))
