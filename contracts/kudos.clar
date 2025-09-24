;; ---------------------------------------------------
;; On-chain Kudos Contract
;;  - Users can give kudos (points) to others
;;  - Tracks kudos received per principal
;; ---------------------------------------------------

(define-constant ERR-SELF-KUDOS (err u100))

;; Store kudos count per user
(define-map kudos
  { user: principal }
  { count: uint }
)

;; Give 1 kudos to another user
(define-public (give-kudos (to principal))
  (begin
    (asserts! (not (is-eq tx-sender to)) ERR-SELF-KUDOS)
    (let ((current (default-to u0 (get count (map-get? kudos { user: to })))))
      (map-set kudos { user: to } { count: (+ current u1) })
      (ok true)
    )
  )
)

;; Get total kudos received by a user
(define-read-only (get-kudos (who principal))
  (ok (default-to u0 (get count (map-get? kudos { user: who }))))
)

