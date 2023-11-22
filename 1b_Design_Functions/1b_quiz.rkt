;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1b_quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; PROBLEM: Design a function that consumes two images and produces true if the first is larger than the second.
(require 2htdp/image)
;; Image Image -> Boolean
;; produces true if first image (height and width are both larger) is larger than second image

(check-expect (larger? (circle 40 "solid" "blue" )
                      (circle 30 "solid" "blue"))
              true) ;compare circles 

(check-expect (larger? (circle 20 "solid" "blue" )
                      (circle 30 "solid" "blue"))
              false) ;compare circles

(check-expect (larger? (circle 20 "solid" "blue" )
                      (circle 20 "solid" "blue"))
              false) ;compare circles

(check-expect (larger? (circle 30 "solid" "blue" )
                      (square 30 "solid" "black"))
              true) ;compare different shapes - circle vs square

(check-expect (larger? (square 60 "solid" "black")
                      (circle 30 "solid" "blue" ))
              true) ;compare different shapes - circle vs square

(check-expect (larger? (circle 30 "solid" "blue")
                      (rectangle 30 40 "solid" "black"))
              true) ;compare different shapes - circle vs rect

(check-expect (larger? (rectangle 30 40 "solid" "black")
                      (circle 30 "solid" "blue" ))
              false) ;compare different shapes - circle vs rect

(check-expect (larger? (rectangle 20 30 "solid" "black")
                      (rectangle 30 40 "solid" "blue" ))
              false) ;compare rectangles - i1 width smaller, i1 height smaller

(check-expect (larger? (rectangle 20 40 "solid" "black")
                      (rectangle 30 40 "solid" "blue" ))
              false) ;compare rectangles - i1 width smaller, i1 height equal

(check-expect (larger? (rectangle 20 40 "solid" "black")
                      (rectangle 30 20 "solid" "blue" ))
              false) ;compare rectangles - i1 width smaller, i2 height smaller

(check-expect (larger? (rectangle 30 30 "solid" "black")
                      (rectangle 30 40 "solid" "blue" ))
              false) ;compare rectangles - i1 width equal, i1 height smaller

(check-expect (larger? (rectangle 30 40 "solid" "black")
                      (rectangle 30 40 "solid" "blue" ))
              false) ;compare rectangles - i1 width equal, i1 height equal

(check-expect (larger? (rectangle 30 40 "solid" "black")
                      (rectangle 30 20 "solid" "blue" ))
              false) ;compare rectangles - i1 width equal, i2 height smaller

(check-expect (larger? (rectangle 40 30 "solid" "black")
                      (rectangle 30 40 "solid" "blue" ))
              false) ;compare rectangles - i1 width larger, i1 height smaller

(check-expect (larger? (rectangle 40 40 "solid" "black")
                      (rectangle 30 40 "solid" "blue" ))
              false) ;compare rectangles - i1 width larger, i1 height equal

(check-expect (larger? (rectangle 40 40 "solid" "black")
                      (rectangle 30 20 "solid" "blue" ))
              false) ;compare rectangles - i1 width larger, i2 height smaller


;(define (larger? i1 i2) false) ;stub

;(define (larger? i1 i2) 
;  (... i1 i2)) ;template

(define (larger? i1 i2) 
  (and (> (image-width i1) (image-width i2))
       (> (image-height i1) (image-height i2))))
