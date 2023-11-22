;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_discussion_shape_first_try) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data definition:
;; Polygon is one of:
;; - 3
;; - 4
;; - 5
;; interp. polygon type - 3 is triangle, 4 is square, 5 is pentagon

;; <examples are redundant for enumerations>

#;
(define(fn-for-polygon p)
  (cond [(= p 3) (...)]
        [(= p 4) (...)]
        [(= p 5) (...)]))

;; Template rules type:
;; - one of: 3 cases
;; - atomic distinct: 3
;; - atomic distinct: 4
;; - atomic distinct: 5 