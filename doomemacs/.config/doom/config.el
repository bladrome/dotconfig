;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "bladrome"
      user-mail-address "blkcat@163.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 19 :weight 'semi-light) ;
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 20))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'vscode-dark-plus)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq bookmark-default-file "~/.config/doom/bookmarks")
(setq recentf-save-file "~/.config/doom/recentf")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (setq debug-on-quit t)
;; (setq debug-on-error t)
;; set transparency
;; (set-frame-parameter (selected-frame) 'alpha '(95 85))
;; (add-to-list 'default-frame-alist '(alpha 95 85))

(setq org-publish-project-alist
      '(("orgfiles"
         :base-directory "~/Documents/2021/"
         :base-extension "org"
         :publishing-directory "~/org/public_html"
         :publishing-function org-html-publish-to-html
         :with-toc nil
         :makeindex
         :auto-sitemap
         :sitemap-sort-files t
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"style/worgstyle.css\" />"
         :html-preamble nil)
        ("images"
         :base-directory "~/Documents/2021/attachments"
         :base-extension "png\\|jpg"
         :recursive t
         :publishing-directory "~/org/public_html/images"
         :publishing-function org-publish-attachment)
        ("other"
         :base-directory "~/other/"
         :base-extension "css\\|el"
         :publishing-directory "~/org/public_html/others"
         :recursive t
         :publishing-function org-publish-attachment)
        ("org" :components ("orgfiles" "images" "other"))))
