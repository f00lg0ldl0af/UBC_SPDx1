;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_Enumeration) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data definitions:
;; StudentGrade is one of:
;; - "A"
;; - "B"
;; - "C"
;; interp. letter grade in a course
;; <examples are redundant for enumerations>

#;
(define (fn-for-student-grade sg)
  (cond[(string=? sg "A") (...)]
       [(string=? sg "B") (...)]
       [(string=? sg "C") (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct value: "A"
;; - atomic distinct value: "B"
;; - atomic distinct value: "C"

;; Functions
;; StudentGrade -> StudentGrade
;; produces next highest student grade (no change if A)
(check-expect (bump-up "A") "A")
(check-expect (bump-up "B") "A")
(check-expect (bump-up "C") "B")

;(define (bump-up sg) "A") ;stub
; <use template from StudentGrade>
(define (bump-up sg)
  (cond[(string=? sg "A") "A"]
       [(string=? sg "B") "A"]
       [(string=? sg "C") "B"]))