(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-attach-id-dir "~/org/public_html/attachments")
 '(custom-safe-themes
   '("2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" default))
 '(fci-rule-color "#37474F")
 '(jdee-db-active-breakpoint-face-colors (cons "#171F24" "#237AD3"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#171F24" "#579C4C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#171F24" "#777778"))
 '(nrepl-message-colors
   '("#00afef" "#778ca3" "#009c9f" "#778ca3" "#005cc5" "#fa1090" "#009c9f" "#778ca3"))
 '(objed-cursor-color "#D16969")
 '(pdf-view-midnight-colors (cons "#d4d4d4" "#1e1e1e"))
 '(rustic-ansi-faces
   ["#1e1e1e" "#D16969" "#579C4C" "#D7BA7D" "#339CDB" "#C586C0" "#85DDFF" "#d4d4d4"])
 '(vc-annotate-background "#1e1e1e")
 '(vc-annotate-color-map
   (list
    (cons 20 "#579C4C")
    (cons 40 "#81a65c")
    (cons 60 "#acb06c")
    (cons 80 "#D7BA7D")
    (cons 100 "#d8ab79")
    (cons 120 "#d99c76")
    (cons 140 "#DB8E73")
    (cons 160 "#d38b8c")
    (cons 180 "#cc88a6")
    (cons 200 "#C586C0")
    (cons 220 "#c97ca3")
    (cons 240 "#cd7286")
    (cons 260 "#D16969")
    (cons 280 "#ba6c6c")
    (cons 300 "#a37070")
    (cons 320 "#8d7374")
    (cons 340 "#37474F")
    (cons 360 "#37474F")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun random-choice (items)
  "Random choice a list"
  (let* ((size (length items))
         (index (random size)))
    (nth index items)))

(defun blkcat/load-theme-random ()
  "Load random themes of doom-*"
  (interactive)
  (let* ((doom-themes (all-completions "doom" (custom-available-themes)))
         (theme       (random-choice doom-themes)))
    (counsel-load-theme-action theme)
    (message "Current random doom-* theme is: %s" theme)
    (setq doom-theme theme)))

;; Get random themes on Emacs startup
(setq doom-theme (random-choice (custom-available-themes)))

(use-package lsp-mode
  :hook (c++-mode . lsp)
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                    :major-modes '(c++-mode)
                    :remote? t
                    :server-id 'clangd-remote)))

(use-package org
  :hook
  (org-mode . turn-on-visual-line-mode)
  :config
  (setq org-directory "~/org/sync/")
  ;; Capture templates for links to pages having [ and ]
  ;; characters in their page titles - notably ArXiv
  ;; From https://github.com/sprig/org-capture-extension
  (require 'org-protocol)
  (defun transform-square-brackets-to-round-ones(string-to-transform)
    "Transforms [ into ( and ] into ), other chars left unchanged."
    (concat
     (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform)))
  (setq org-capture-templates `(
                                ("p" "Protocal" entry (file+headline ,(concat "~/Documents/2021/" (format-time-string "%Y%m%d") ".org") "arxiv")
                                 "* [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n \n%i\n\n\n\n%?")
                                ("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes_" (shell-command-to-string "date +%F__%H-%M-%S_%Z")) "Inbox")
                                 "* %^{Title_and_tag}\n [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n")
                                )))

;; "* %^{Title_and_tag}\nSource: [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
