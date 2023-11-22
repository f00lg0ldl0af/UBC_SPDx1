;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Project_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Simple text editor, like a Google search bar:

;; =================
;; Constants:
(define WIDTH 200)
(define HEIGHT 20)

(define MTS (empty-scene WIDTH HEIGHT))

(define FONT-SIZE HEIGHT)
(define FONT-COLOR "Dark Brown")

(define CURSOR (rectangle 2 HEIGHT "solid" "red"))
(define CURSOR2 (rectangle 2 HEIGHT "solid" "white"))

;; =================
;; Data definitions:
(define-struct tb (txt cpos cstate))
;; TextBox is (make-tb String Natural Natural)
;; interp. a textbox with:
;;         - txt: text 
;;         - cpos: cursor position
;;         - cstate: cursor state (for blinking effect)

(define TB1 (make-tb " " 0 0)) ;; empty, cursor red
(define TB2 (make-tb "amazing" 0 1)) ;; |amazing, cursor white 
(define TB3 (make-tb "amazing" 2 2)) ;; am|azing, cursor red
(define TB4 (make-tb "amazing" 7 3)) ;; amazing|, cursor white


#;
(define (fn-for-tb tb)
  (... (tb-txt tb)     ;String
       (tb-cpos tb)    ;Natural
       (tb-cstate tb)));Natural

;; Template rules used:
;;  - compound: 3 fields


;; =================
;; Functions:

;; TextBox -> TextBox
;; start the world with (main (make-tb "" 0 0))

(define (main tb)
  (big-bang tb                      ; TextBox
            (on-tick   blink-tb 4)  ; TextBox -> TextBox
            (to-draw   render-tb)   ; TextBox -> Image
            (on-key    handle-key))); TextBox KeyEvent -> TextBox

;; TextBox -> TextBox
;; produce the next TextBox with different cstate (marks cursor color, either red or white)
(check-expect (blink-tb (make-tb "" 0 0))
              (make-tb "" 0 1))

(check-expect (blink-tb (make-tb "" 0 1))
              (make-tb "" 0 2))              


;(define (blink-tb tb) tb) ;stub

(define (blink-tb tb)
  (make-tb (tb-txt tb)
           (tb-cpos tb)
           (+ (tb-cstate tb) 1)))

;; TextBox -> Image
;; Choose image of cursor depending on cstate
;;        - CURSOR: white
;;        - CURSOR2: white 
(check-expect (choose-cursor (make-tb "" 0 0))
              CURSOR) ;red when cstate-tb is even

(check-expect (choose-cursor (make-tb "" 0 1))
              CURSOR2) ;white when cstate-tb is odd

;(define (choose-cursor tb) CURSOR) ;stub

(define (choose-cursor tb)
  (if (even? (tb-cstate tb))
      CURSOR
      CURSOR2))


;; TextBox -> Image
;; render textbox with text and cursor, each lined up from left of MTS, and on their centres
(check-expect (render-tb (make-tb "amazing" 0 0))
              (overlay/align "left"
                             "middle"
                             (beside (choose-cursor (make-tb "amazing" 0 0))
                                     (text "amazing" FONT-SIZE FONT-COLOR))
                             MTS)) ;cursor at start of text

(check-expect (render-tb (make-tb "amazing" 4 0))
              (overlay/align "left"
                             "middle"
                             (beside (text "amaz" FONT-SIZE FONT-COLOR)
                                     (choose-cursor (make-tb "amazing" 4 0))
                                     (text "ing" FONT-SIZE FONT-COLOR))
                             MTS)) ;cursor at middle of text

(check-expect (render-tb (make-tb "amazing" 7 0))
              (overlay/align "left"
                             "middle"
                             (beside (text "amazing" FONT-SIZE FONT-COLOR)
                             (choose-cursor (make-tb "amazing" 7 0)))
                             MTS)) ;cursor at end of text

;(define (render-tb tb) MTS) ;stub
; Use Template from TextBox
(define (render-tb tb)
  (overlay/align "left"
                 "middle"
                 (beside (text (substring (tb-txt tb) 0 (tb-cpos tb))
                               FONT-SIZE
                               FONT-COLOR)
                         (choose-cursor tb)
                         (text (substring (tb-txt tb) (tb-cpos tb) (string-length (tb-txt tb)))
                               FONT-SIZE
                               FONT-COLOR))
                 MTS))

;; TextBox KeyEvent -> TextBox
;; calls appropriate function when key pressed:
;;                                 - "left": cpos moves left
;;                                 - "right": cpos moves right
;;                                 - "\b": deletes the text (if any) before cpos
;;                                 -  all other keys: append key(s) as String to txt, at cpos

(check-expect (handle-key (make-tb "amazing" 0 0) "left")
              (make-tb "amazing" 0 0)) ;no text before cpos, "left" key pressed

(check-expect (handle-key (make-tb "amazing" 3 0) "left")
              (make-tb "amazing" 2 0)) ;text before cpos, "left" key pressed

(check-expect (handle-key (make-tb "amazing" 7 0) "right")
              (make-tb "amazing" 7 0)) ;no text after cpos, "right" key pressed

(check-expect (handle-key (make-tb "amazing" 3 1) "right")
              (make-tb "amazing" 4 1)) ;text after cpos, "right" key pressed

(check-expect (handle-key (make-tb "amazing" 0 1) "\b")
              (make-tb "amazing" 0 1)) ;no text before cpos, "\b" key pressed

(check-expect (handle-key (make-tb "amazing" 3 1) "\b")
              (make-tb "amzing" 2 1)) ;text before cpos, "\b" key pressed

(check-expect (handle-key (make-tb "amazing" 3 1) "z")
              (make-tb "amazzing" 4 1)) ; "z" key pressed at cpos
              
;(define (handle-key tb ke) (make-tb "amazing" 0 0)) ;stub


(define (handle-key tb ke)
  (cond [(key=? ke "left") (cleft tb)] 
        [(key=? ke "right") (cright tb)]
        [(key=? ke "\b") (cback tb)]
        [(= (string-length ke) 1) (addtxt tb ke)] ; all other keys
        [else tb]))

;; TextBox -> TextBox
;; move cpos leftwards by 1 screenpixel when "left" key pressed
(check-expect (cleft (make-tb "amazing" 0 0))
              (make-tb "amazing"
                       (tb-cpos (make-tb "amazing" 0 0)) 0))

(check-expect (cleft (make-tb "amazing" 1 0))
              (make-tb "amazing"
                       (- (tb-cpos (make-tb "amazing" 1 0)) 1) 0))
#;
(define (cleft tb)
  (make-tb "amazing" 0 0)) ;stub

(define (cleft tb)
  (if (> (tb-cpos tb) 0)
      (make-tb (tb-txt tb)(- (tb-cpos tb) 1) (tb-cstate tb))
      tb))

;; TextBox -> TextBox
;; move cpos rightwards by 1 screenpixel when "right" key pressed
(check-expect (cright (make-tb "amazing" 7 0))
              (make-tb "amazing"
                       (tb-cpos (make-tb "amazing" 7 0)) 0))

(check-expect (cright (make-tb "amazing" 6 0))
              (make-tb "amazing"
                       (+ (tb-cpos (make-tb "amazing" 6 0)) 1) 0))
#;
(define (cright tb)
  (make-tb "amazing" 0 0)) ;stub

(define (cright tb)
  (if (< (tb-cpos tb) (string-length (tb-txt tb)))
      (make-tb (tb-txt tb)(+ (tb-cpos tb) 1)(tb-cstate tb))
      tb))

;; TextBox -> TextBox
;; when "\b" key pressed:
;;                       1) render original text without the character at index before cpos
;;                       2) then, move cpos leftwards by 1 screenpixel  
(check-expect (cback (make-tb "amazing" 4 0))
              (make-tb
               (string-append (substring "amazing" 0 (- 4 1)) (substring "amazing" 4 (string-length "amazing")))
               (- 4 1)
               0)) ;string length > 0 and cpos <= string length and cpos > 0

(check-expect (cback (make-tb "amazing" 0 0))
              (make-tb "amazing" 0 0)) ;string length > 0 and cpos = 0

(check-expect (cback (make-tb "" 0 0))
              (make-tb "" 0 0)) ; string length = 0 

(define (cback tb)
  (cond [(and
          (> (string-length (tb-txt tb)) 0)
          (> (tb-cpos tb) 0)
          (<= (tb-cpos tb) (string-length (tb-txt tb))))
         (make-tb
          (string-append
           (substring (tb-txt tb) 0 (- (tb-cpos tb) 1))
           (substring (tb-txt tb) (tb-cpos tb) (string-length (tb-txt tb))))
          (- (tb-cpos tb) 1)
          (tb-cstate tb))]

        [(and (> (string-length (tb-txt tb)) 0)
          (= (tb-cpos tb) 0))
         (make-tb (tb-txt tb) 0 (tb-cstate tb))]
        
        [else tb]))

#;
(define (cback tb)
  (make-tb "amazing" 0)) ;stub

;; TextBox -> TextBox
;; append "a" to original text at tb-cpos when e.g., "a" key pressed
(check-expect (addtxt (make-tb "a" 1 0) "a")
              (make-tb "aa" 2 0)) ;text before cpos, cpos = string length, cpos > 0

(check-expect (addtxt (make-tb "aa" 1 0) "a")
              (make-tb "aaa" 2 0)) ;text before cpos, cpos < string length, cpos > 0

(check-expect (addtxt (make-tb "" 0 1) "a")
              (make-tb "a" 1 1)) ;no text before cpos, cpos = 0

(check-expect (addtxt (make-tb "a" 0 1) "a")
              (make-tb "aa" 1 1)) ;text before cpos, cpos = 0




(define (addtxt tb ke)
  (cond [(and
          (> (string-length (tb-txt tb)) 0)
          (>= (tb-cpos tb) 0)
          (<= (tb-cpos tb) (string-length (tb-txt tb))))
         (make-tb (string-append (substring (tb-txt tb) 0 (tb-cpos tb))
                        ke
                        (substring (tb-txt tb) (tb-cpos tb) (string-length (tb-txt tb))))
                  (+ (tb-cpos tb) 1)
                  (tb-cstate tb))]
        
        [else (make-tb ke (+ (tb-cpos tb)1) (tb-cstate tb))]))

