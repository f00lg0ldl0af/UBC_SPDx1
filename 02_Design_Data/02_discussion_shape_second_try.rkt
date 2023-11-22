;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_discussion_shape_second_try) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Data definition:
(define-struct shape (x y))
;; Shape is (make-shape Natural[3,5] Natural
;; interp. a shape with x sides (3: triangle, 4: square, 5: pentagon) and length of side y 

(define Shape-1 (make-shape 3 10)) ;Triangle with side 10
(define Shape-2 (make-shape 4 5))  ;Square   with side 5
(define Shape-3 (make-shape 5 20)) ;Pentagon with side 20

(define (fn-for-shape b)
  (... (shape-x b)     ;Natural[3,5]
       (shape-y b)))   ;Number[>= 0]

#;
(define (fn-for-shape s)
  (cond [(= (shape-x s) 3) (... (shape-y s))]
        [(= (shape-x s) 4) (... (shape-y s))]
        [(= (shape-x s) 5) (... (shape-y s))]))

;; Template rules used:
;; - compound: 2 fields

;; Functions
;; Shape -> Number
;; area: return the area of the shape of a triangle, square, or pentagon. (All the figures have equal sides.)

(check-within (area Shape-1) (* (/(sqrt 3) 4)(sqr (shape-y Shape-1))) 0.01)
(check-expect (area Shape-2) 25)
(check-within (area Shape-3) 688.19 0.01)
(check-within (area (make-shape 3 48)) 997.66 0.01)
(check-expect (area (make-shape 4 10)) 100)
(check-within (area (make-shape 5 24)) 990.99 0.01)

;(define (area s) 0) ;stub

(define (area s)
  (cond [(= (shape-x s) 3) (* (/(sqrt 3) 4)(sqr (shape-y s)))]
        [(= (shape-x s) 4) (sqr (shape-y s))]
        [else (/ (* 5/4 (sqr (shape-y s))) (tan (/ pi 5)))]))