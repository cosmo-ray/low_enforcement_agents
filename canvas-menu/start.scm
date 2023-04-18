;           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;                   Version 2, December 2004
;
; Copyright (C) 2023 Matthias Gatto <uso.cosmo.ray@gmail.com>
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;  0. You just DO WHAT THE FUCK YOU WANT TO.

(begin
  ;; entry point
  (define y_canvas_mk_menu
    (lambda (test)
      (begin
	(display "hello callback !!!\n")
	(display test)
       )
      )
    )
  (define mod_init
    (lambda (mod)
      (begin
	(display "canvas-menu INIT\n")
	(ygRegistreFunc 1 "y_canvas_mk_menu" "y_canvas_mk_menu")
	(yaeString "canvas-menu" mod "name")
	)
      )
    )
  )
