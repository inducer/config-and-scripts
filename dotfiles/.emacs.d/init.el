; setup load path ---------------------------------------------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq dotfiles-dir (file-name-directory
                     (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat dotfiles-dir "my-packages"))

; {{{ customize stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(async-bytecomp-package-mode t)
 '(auto-save-visited-mode t)
 '(browse-url-browser-function 'browse-url-generic)
 '(browse-url-firefox-new-window-is-tab t)
 '(browse-url-generic-program "xdg-open")
 '(comint-prompt-read-only t)
 '(comint-scroll-show-maximum-output nil)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(delete-by-moving-to-trash t)
 '(fci-rule-color "#383838")
 '(global-auto-revert-mode t)
 '(gnus-alias-default-identity "uofi")
 '(gnus-alias-identity-alist
   '(("uofi" "" "\"Andreas Kloeckner\" <andreask@illinois.edu>" "University of Illinois" nil "" "Andreas Kloeckner
Room 4318 (Siebel Center), University of Illinois at Urbana-Champaign
https://andreask.cs.illinois.edu/aboutme
+1-217-244-6401")
     ("tician" "" "\"Andreas Kloeckner\" <mathem@tician.de>" "" nil "" "")
     ("de" "" "\"Andreas Kloeckner\" <mathem@tiker.net>" "" nil "" "")
     ("inform" "" "\"Andreas Kloeckner\" <inform@tiker.net>" "" nil "" "")
     ("lists" "" "\"Andreas Kloeckner\" <lists@informa.tiker.net>" "" nil "" "")
     ("cna" "" "Cabral Bigman & Andreas Kloeckner <cna@tiker.net>" "" nil "" "")))
 '(hl-sexp-background-color "#efebe9")
 '(ispell-dictionary "en_US")
 '(ispell-highlight-face 'flyspell-incorrect)
 '(ispell-program-name "aspell")
 '(mail-specify-envelope-from t)
 '(mailcap-download-directory "~/tmp/")
 '(message-confirm-send t)
 '(message-expand-name-databases '(eudc))
 '(message-hidden-headers
   '("^User-Agent:" "^References:" "^Face:" "^X-Face:" "^X-Draft-From:"))
 '(message-mail-alias-type nil)
 '(message-send-mail-function 'message-send-mail-with-sendmail)
 '(message-send-mail-partially-limit nil)
 '(message-sendmail-envelope-from 'header)
 '(mml-secure-key-preferences
   '((OpenPGP
      (sign
       ("mathem@tician.de" "900A958D9A0ACA58B1468F2471AA298BCA171145")
       ("andreask@illinois.edu" "900A958D9A0ACA58B1468F2471AA298BCA171145"))
      (encrypt
       ("mathem@tician.de" "900A958D9A0ACA58B1468F2471AA298BCA171145")))
     (CMS
      (sign)
      (encrypt))))
 '(mml-secure-openpgp-encrypt-to-self t)
 '(notmuch-address-command 'internal)
 '(notmuch-archive-tags '("-inbox" "+archived"))
 '(notmuch-fcc-dirs "offlineimap-badger/Sent -inbox +sent -unread")
 '(notmuch-saved-searches
   '((:name "Inbox" :query "tag:inbox and not tag:draft and not tag:deleted")
     (:name "Waiting" :query "tag:waiting")
     (:name "Flagged" :query "tag:flagged")
     (:name "Snoozed" :query "tag:snoozed or tag:evesnoozed or tag:weeksnoozed")
     (:name "Recommendation letters" :query "tag:snoozed")
     (:name "To-Do Later" :query "tag:todolater")))
 '(notmuch-search-oldest-first nil)
 '(notmuch-show-indent-messages-width 0)
 '(notmuch-show-text/html-blocked-images ".*")
 '(notmuch-tag-formats
   '(("unread"
      (propertize tag 'face 'notmuch-tag-unread))
     ("flagged"
      (notmuch-tag-format-image-data tag
                                     (notmuch-tag-star-icon))
      (propertize tag 'face 'notmuch-tag-flagged))
     ("uillinois"
      (notmuch-apply-face tag
                          '(:foreground "dark blue")))
     ("github"
      (notmuch-apply-face tag
                          '(:foreground "deep sky blue")))
     ("teaching"
      (notmuch-apply-face tag
                          '(:foreground "magenta")))))
 '(notmuch-tagging-keys
   '(("a" notmuch-archive-tags "Archive")
     ("u" notmuch-show-mark-read-tags "Mark read")
     ("f"
      ("+flagged")
      "Flag")
     ("s"
      ("+spam" "-inbox")
      "Mark as spam")
     ("D"
      ("+deleted" "-inbox")
      "Delete")
     ("e"
      ("+evesnoozed" "-inbox")
      "Snooze until evening")
     ("n"
      ("+snoozed" "-inbox")
      "Snooze until tomorrow")
     ("w"
      ("+weeksnoozed" "-inbox")
      "Snooze until Monday")
     ("R"
      ("+reclet" "-inbox")
      "Recommendation letter to-do")
     ("l"
      ("+todolater" "-inbox")
      "Mark as to be done later, tracked via Org")))
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(olivetti-body-width 100)
 '(org-agenda-custom-commands
   '(("ct" "TODOs sorted by state, priority, effort" todo "*"
      ((org-agenda-overriding-header "TODOs sorted by state, priority, effort")
       (org-agenda-sorting-strategy
        '(todo-state-down priority-down effort-up))
       (org-agenda-skip-function
        '(org-agenda-skip-entry-if 'deadline))))))
 '(org-agenda-files
   '("/home/andreas/org/todo.org" "/home/andreas/org/notes.org" "/home/andreas/org/ideas.org"))
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sticky t)
 '(org-agenda-window-setup 'current-window)
 '(org-beamer-environments-extra '(("hidden" "h" "\\begin{hidden}" "\\end{hidden}")))
 '(org-capture-templates
   '(("n" "Note" entry
      (file "~/org/notes.org")
      "** %?")
     ("t" "To-do item" entry
      (file "~/org/todo.org")
      "* TODO %i%?
SCHEDULED: %t DEADLINE: %t
%a")))
 '(org-capture-use-agenda-date t)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-format-latex-header
   "\\documentclass{article}
\\usepackage[usenames]{color}
[PACKAGES]
[DEFAULT-PACKAGES]
\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}
\\usepackage{tikz}
\\usetikzlibrary{calc}
\\usetikzlibrary{positioning}
\\usetikzlibrary{shapes.geometric}
\\usetikzlibrary{shapes.arrows}
\\usetikzlibrary{shadows}

\\newcommand{\\abs}[1]{\\left| #1 \\right|}
\\newcommand{\\norm}[1]{\\left\\| #1 \\right\\|}
\\newcommand{\\ip}[1]{\\left\\langle #1, \\right\\rangle}
\\newcommand{\\mathd}{\\mathrm{d}}

\\let\\B=\\mathbf
\\let\\b=\\mathbf
\\let\\op=\\operatorname")
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-loop-over-headlines-in-active-region t)
 '(org-pretty-entities t)
 '(org-pretty-entities-include-sub-superscripts nil)
 '(org-preview-latex-default-process 'imagemagick)
 '(org-src-preserve-indentation t)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(ace-window evil-collection flycheck-pycheckers markdown-mode flycheck editorconfig magit monokai-theme zenburn-theme nyx-theme dracula-theme nord-theme gruvbox-theme olivetti leuven-theme focus evil-easymotion base16-theme htmlize ox-gfm org helm color-theme-solarized evil evil-org company))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(printer-name "PDF")
 '(ps-paper-type 'letter)
 '(ps-printer-name nil)
 '(safe-local-variable-values
   '((bibtex-completion-bibliography . "../references/refs.bib")
     (reftex-default-bibliography . "../references/refs.bib")
     (org-ref-default-bibliography . "../references/refs.bib")
     (org-latex-prefer-user-labels . t)))
 '(save-place t nil (saveplace))
 '(send-mail-function 'sendmail-send-it)
 '(sendmail-program "/home/andreas/bin/my-sendmail")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode '(only . t))
 '(truncate-lines t)
 '(uniquify-buffer-name-style 'forward nil (uniquify))
 '(user-full-name "Andreas Klöckner")
 '(user-mail-address "andreas@tiker.net")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "Liberation Mono"))))
 ;; '(message-header-to ((t (:foreground "black" :weight bold))))
 ;; '(notmuch-search-unread-face ((t (:weight bold)))))
(if (display-graphic-p)
  (load-theme 'leuven t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 120 :width normal :foundry "CYEL" :family "Iosevka Term"))))
 '(italic ((t (:foreground "gray" :slant italic))))
 '(message-cited-text-1 ((t (:foreground "#888"))))
 '(notmuch-message-summary-face ((t (:background "#303030" :foreground "gray"))))
 '(notmuch-search-flagged-face ((t (:foreground "yellow"))))
 '(notmuch-tag-flagged ((t (:foreground "yellow"))))
 '(org-todo ((t (:background "#dc322f" :foreground "#fff" :weight bold)))))

; }}}

; set up various stuff -----------------------------------------------------
(when (string= system-name "lightning")
  (require 'notmuch)
  (require 'org-notmuch)
  )

(require 'gnus-art)
(require 'gnus-alias)
(require 'zoom-frm)
(require 'helm-config)

(autoload 'gnus-alias-determine-identity "gnus-alias" "" t)
(add-hook 'message-setup-hook 'gnus-alias-determine-identity)

(setq inhibit-splash-screen t)

;(require 'atomic-chrome)
;(atomic-chrome-start-server)

; Prevent changing font on DPI change?
; https://emacs.stackexchange.com/a/32664
; (define-key special-event-map [config-changed-event] 'ignore)

(defun my-message-setup-routine ()
  (flyspell-mode 1)
  (abbrev-mode 1)

  ; ; https://emacs.stackexchange.com/questions/19867/set-the-pgp-signing-marker-to-the-top-of-the-new-message/19869
  ; (goto-char (point-min))
  ; (search-forward "--text follows this line--")
  ; (end-of-line)
  ; (insert "\n")

  ; (mml-secure-message-sign)
  )

(add-hook 'message-setup-hook 'my-message-setup-routine)

; {{{ MML SIGN FIX BEGIN

; https://svn.red-bean.com/repos/kfogel/trunk/.emacs:

;; Anyway, the main thing is, when this wasn't set, then sending a
;; GPG-signed message (which happens automatically when replying to
;; someone else's GPG-signed message) would error with the familiar
;; "Couldn't find any signer names." message, the same one that, IIRC,
;; prompted me to set `mml-secure-smime-sign-with-sender' earlier.
;; Please, please let this work for at least a few years this time.
;;
;; Aha!  It's all https://debbugs.gnu.org/cgi/bugreport.cgi?bug=40118
;; Thanks to Eli Zaretskii and Robert Pluim for pointing this out.

;(setq mml-secure-openpgp-sign-with-sender t)
;(setq mml-secure-smime-sign-with-sender t)
(setq mm-sign-option 'guided)

; }}}

(ispell-change-dictionary "american")

(global-flycheck-mode)

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "de_DE") "american" "de_DE")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f7>")   'fd-switch-dictionary)
(setq evil-want-C-i-jump nil)
(setq evil-want-C-u-scroll t)

; needed by evil-collection
; (setq evil-want-keybinding nil)

(require 'evil)
(evil-mode 1)
(evil-set-initial-state 'notmuch-tree-mode 'emacs)
; (evil-collection-init)

; {{{ org-related

(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional))
(setq org-latex-prefer-user-labels t)

(setq org-fontify-whole-heading-line t)

; https://emacs.stackexchange.com/questions/38184/org-mode-ignore-heading-when-exporting-to-latex
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

; }}}

; {{{ sync-org-to-git 

(defun sync-org-to-git ()
  (interactive)
  (let (bufs-to-delete
        (orgdir (expand-file-name "~/org/")))
    (dolist (buf (buffer-list) bufs-to-delete)
      (let (fn dn)
        (setq fn (buffer-file-name buf))
        (setq dn
              (if fn
                  (file-name-directory fn)
                nil))
        (if (equal dn orgdir)
            (setq bufs-to-delete (cons buf bufs-to-delete)))
        ))
    (dolist (buf bufs-to-delete)
      (with-current-buffer buf (save-buffer))
      (kill-buffer buf)
      )
    (shell-command "cd ~/org && git sync &")
    ))

; }}}

(quietly-read-abbrev-file)
(setq default-abbrev-mode t)

(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

; {{{ theme

(defvar ak-theme-lightness 'light)
(defun ak-toggle-theme-lightness()
  (interactive)
  (setq ak-theme-lightness
        (if (eq ak-theme-lightness 'light) 'dark 'light) )
  ;(customize-set-variable 'frame-background-mode ak-theme-lightness)
  ; https://www.reddit.com/r/emacs/comments/30b67j/how_can_you_reset_emacs_to_the_default_theme/
  (mapcar #'disable-theme custom-enabled-themes)
  (if (eq ak-theme-lightness 'light)
    (load-theme 'leuven t)
    (progn
      (load-theme 'zenburn t)
      (custom-theme-set-faces
        'zenburn
        '(org-level-1 ((t (:background "#666666" :height 1.3 :extend t))))
        '(org-level-2 ((t (:background "#555555" :height 1.15 :extend t))))
        '(org-level-3 ((t (:background "#444444" :height 1.15 :extend t))))
        )
      ; https://emacs.stackexchange.com/a/60628
      (enable-theme 'zenburn)
      )
    )
  )

; }}}

(setq-default indent-tabs-mode nil)

; Evil easymotion
(evilem-default-keybindings "C-m")

; (server-mode 1)
; (global-auto-revert-mode t)

; {{{ disable doc-view-mode

; https://emacs.stackexchange.com/questions/22736/org-mode-how-to-disable-automatic-doc-view-on-emacs-25
(defun ensc/mailcap-mime-data-filter (filter)
  ""
  (mapcar (lambda(major)
        (append (list (car major))
            (remove nil
                (mapcar (lambda(minor)
                      (when (funcall filter (car major) (car minor) (cdr minor))
                    minor))
                    (cdr major)))))
      mailcap-mime-data))

(defun ensc/no-pdf-doc-view-filter (major minor spec)
  (if (and (string= major "application")
       (string= minor "pdf")
       (member '(viewer . doc-view-mode) spec))
      nil
    t))

(eval-after-load 'mailcap
  '(progn
     (setq mailcap-mime-data
       (ensc/mailcap-mime-data-filter 'ensc/no-pdf-doc-view-filter))))

; }}}

; {{{ key bindings

(define-key global-map [f9]     'compile)
(define-key global-map [f8]     'ak-toggle-theme-lightness)
(define-key global-map [f3]     'org-cycle-agenda-files)
(define-key global-map [f2]     'sync-org-to-git)
(define-key global-map [f12]     'browse-url-at-point)
(define-key global-map [(control ?')]     'org-cycle-agenda-files)
(define-key global-map [(control ?.)]     'browse-url)

(define-key notmuch-message-mode-map (kbd "C-c C-i")  'gnus-alias-select-identity)

(define-key ctl-x-map [(control ?+)] 'zoom-in/out)
(define-key ctl-x-map [(control ?-)] 'zoom-in/out)
(define-key ctl-x-map [(control ?=)] 'zoom-in/out)
(define-key ctl-x-map [(control ?0)] 'zoom-in/out)

(define-key global-map (kbd "C-w") 'evil-window-map)

;(define-key viper-vi-global-user-map "v" 'set-mark-command)
;(define-key viper-vi-global-user-map "V" 'set-mark-command)

;; '(message-default-mail-headers "Fcc: ~/mail/offlineimap-weasel/Sent")

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

; }}}

; vim: foldmethod=marker
