(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
    '(org-agenda-files
    '("/home/bladrome/Documents/2021/paper.org" "/home/bladrome/Documents/2021/20210926.org" "/home/bladrome/org/journal.org" "/home/bladrome/org/notebook.org" "/home/bladrome/org/notes.org" "/home/bladrome/org/self.org" "/home/bladrome/org/todo.org" "/home/bladrome/org/work.org"))
 '(warning-suppress-types '((org-mode-hook))))
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


;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(transparency 80)

;; Get random themes on Emacs startup
;; (setq doom-theme (random-choice (custom-available-themes)))
