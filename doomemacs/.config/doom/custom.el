(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
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
;; (setq doom-theme (random-choice (custom-available-themes)))
