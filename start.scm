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

  (define move_up
    (lambda (wid)
      (display "up\n")
      (yGenericHandlerMoveXY (yeGet wid "guy_layer") 0 -16)
      )
    )
  (define move_down
    (lambda (wid)
      (display "down\n")
      ;(yePrint (yeGet wid "guy_layer"))
      (yGenericHandlerMoveXY (yeGet wid "guy_layer") 0 16)
      )
    )

  (define lof_action
    (lambda (wid eves)
      ;; if keydown is push
      (display "action !\n")
      (if (yevIsGrpDown eves (yeGet wid "down_k")) (move_down wid))
      (if (yevIsGrpDown eves (yeGet wid "up_k")) (move_up wid))
      YEVE_ACTION
      )
    )

  (define lof_init
    (lambda (wid unues_type)
      (display "low_enforcement_agents Widget Init\n")

      ;; print score on the top of the screen
      (ywCanvasNewTextByStr wid 40 20 "score:")
      ;; a line to separte the score from the road
      (ywCanvasNewHSegment wid 0 60 1000 "rgba: 0 0 0 255")

      ;; show the road
      (ywCanvasNewImgByPath wid 125 64 "road.png")
      (ywCanvasNewImgByPath wid 125 (+ 64 125) "road.png")
      (ywCanvasNewImgByPath wid 125 (+ 64 250) "road.png")
      (ywCanvasNewImgByPath wid 125 (+ 64 375) "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) 64 "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) (+ 64 125) "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) (+ 64 250) "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) (+ 64 375) "road.png")

      ;; create a "group" that match keyboard down/s key
      (yePushBack wid (yevCreateGrp Y_DOWN_KEY Y_S_KEY) "down_k")
      ;; create a "group" that match keyboard UP/w key
      (yePushBack wid (yevCreateGrp Y_UP_KEY Y_W_KEY) "up_k")

      ;; add the cop, using yGenericNewCanvasLayer, push it to wid
      (yePushBack  wid
       (yGenericNewCanvasLayer
	wid
	(yaePushBack
	 (yaePushBack (yeCreateArray)
		      (ywCanvasNewImgByPath wid 64 (+ 64 0) "pixil-layer-0.png"))
	 (ywCanvasNewImgByPath wid 124 (+ 64 0) "pixil-layer-1.png")
	 )
	(yaeString "layer-canvas" (yeCreateArray) "type")
	)
       "guy_layer")
      ;; action callback called at each tick
      (yeCreateFunction "lof_action" wid "action")
      ;; set to real time
      (ywSetTurnLengthOverwrite 100000)
      (yePrint (ygFileToEnt YJSON "levels.json"))

      ;; canvas widget, and set a white background
      ;; yaeString is like yeCreateString, but yeCreateString return the string,
      ;; and yae, it's parent
      (y_canvas_mk_menu "hello!!\n")
      (ywidNewWidget (yaeString "rgba: 255 255 255 255" wid "background") "canvas")
      )
    )

  ;; entry point
  (define mod_init
    (lambda (mod)
      (begin
	(display "low_enforcement_agents INIT \n\n")
	;; add smart_cobject, so we can use smart_cobject functions (yGeneric*)
	(ygAddModule Y_MOD_YIRL mod "smart_cobject")
	(ygAddModule Y_MOD_LOCAL mod "./canvas-menu")
	;; ygInitWidgetModule simplify the creation of a mod that contain only a widget
	;; it also add a starting widget of that widget
	;; if you want to do that manially, you can do it like it's done in pong
	(ygInitWidgetModule mod "low_enforcement_agents" (yeCreateFunction "lof_init"))
	mod
	)
      )
    )
  )
