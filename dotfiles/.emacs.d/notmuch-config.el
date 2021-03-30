(define-key notmuch-show-mode-map "b"
  (lambda (&optional address)
    "Bounce the current message."
    (interactive "sBounce To: ")
    (notmuch-show-view-raw-message)
    (message-resend address)))

(defun message-delete-remaining-citation ()
  (interactive)
  (evil-ex ".,/^[^>]/d")
  (newline-and-indent)
  (next-line -1))

(define-key notmuch-message-mode-map (kbd "C-c d c") 'message-delete-remaining-citation)
(define-key notmuch-message-mode-map (kbd "C-c p") 'gnus-personality-choose)

(require 'notmuch-address)
(setq notmuch-address-command "~/bin/notmuch-addrlookup")
(notmuch-address-message-insinuate)

