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
      (if (yevIsGrpDown eves (yeGet wid "down_k")) (move_down wid))
      (if (yevIsGrpDown eves (yeGet wid "up_k")) (move_up wid))
      YEVE_ACTION
      )
    )

  (define lof_init
    (lambda (wid unues_type)
      (display "low_enforcement_agents Widget Init\n")
      (ywCanvasNewTextByStr wid 40 20 "score:")

      (ywCanvasNewHSegment wid 0 60 1000 "rgba: 0 0 0 255")

      (ywCanvasNewImgByPath wid 125 64 "road.png")
      (ywCanvasNewImgByPath wid 125 (+ 64 125) "road.png")
      (ywCanvasNewImgByPath wid 125 (+ 64 250) "road.png")
      (ywCanvasNewImgByPath wid 125 (+ 64 375) "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) 64 "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) (+ 64 125) "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) (+ 64 250) "road.png")
      (ywCanvasNewImgByPath wid (* 125 2) (+ 64 375) "road.png")

      (yePushBack wid (yevCreateGrp Y_DOWN_KEY) "down_k")
      (yePushBack wid (yevCreateGrp Y_UP_KEY) "up_k")


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
      (yeCreateFunction "lof_action" wid "action")
      (ywSetTurnLengthOverwrite -1)
      (ywidNewWidget (yaeString "rgba: 255 255 255 255" wid "background") "canvas")
      )
    )

  (define mod_init
    (lambda (mod)
      (begin
	(display "low_enforcement_agents INIT \n\n")
	(ygAddModule Y_MOD_YIRL mod "smart_cobject")
	(ygInitWidgetModule mod "low_enforcement_agents" (yeCreateFunction "lof_init"))
	mod
	)
      )
    )
  )
