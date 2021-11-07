;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "bladrome"
      user-mail-address "blkcat@163.com")

(setq package-archives
    '(("melpa" . "http://mirrors.bfsu.edu.cn/elpa/melpa/")
      ("org"   . "http://mirrors.bfsu.edu.cn/elpa/org/")
      ("gnu"   . "http://mirrors.bfsu.edu.cn/elpa/gnu/")))


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
;; (setq doom-font (font-spec :family "monospace" :size 19 :weight 'semi-light) ;
      ;; doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 20))

(setq doom-font (font-spec :family "Roboto Mono" :size 19)
     doom-serif-font (font-spec :family "Roboto Mono" :size 20)
     doom-variable-pitch-font (font-spec :family "SourceHanSerifCN")
     doom-unicode-font (font-spec :family "SourceHanSerifCN")
     doom-big-font (font-spec :family "SourceHanSerifCN" :size 23)
     )



;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ayu-mirage)
;; (setq doom-theme nil)
;; (require 'disp-table)
;; (require 'nano-faces)
;; (require 'nano-colors)
;; (require 'nano-theme)
;; (require 'nano-theme)
;; ;; (require 'nano-help)
;; ;; (require 'nano-splash)
;; ;; (require 'nano-modeline)
;; (nano-faces)
;; (nano-theme)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-attach-id-dir "/home/bladrome/Documents/2021/attachments")
;; (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdfxe %f"))


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

(setq org-export-babel-evaluate nil)
(setq org-publish-project-alist
      '(("orgfiles"
         :base-directory "~/Documents/2021/"
         :base-extension "org"
         :publishing-directory "~/org/public_html"
         :publishing-function org-html-publish-to-html
         :with-toc t
         :auto-preamble t
         :auto-sitemap
         :sitemap-title "Notes"
         :sitemap-sort-files
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"style/worg.css\" />"
         :html-preamble nil)
        ("images"
         :base-directory "~/Documents/2021/attachments"
         :base-extension "png\\|jpg\\|webp"
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


(after! dired
  (setq dired-listing-switches "-aBhl  --group-directories-first"
        dired-dwim-target t
        dired-recursive-copies (quote always)
        dired-recursive-deletes (quote top)
        ;; Directly edit permisison bits!
        wdired-allow-to-change-permissions t
        dired-omit-mode nil))


;; (use-package! org-special-block-extras
;;   :ensure t
;;   :hook (org-mode . org-special-block-extras-mode)
;;   ;; All relevant Lisp functions are prefixed ‘o-’; e.g., `o-docs-insert'.
;;   )


(use-package! pangu-spacing
  :config
  (global-pangu-spacing-mode 1)
  (setq pangu-spacing-real-insert-separtor t))

(use-package! valign
  :config
  (setq valign-fancy-bar t)
  (add-hook 'org-mode-hook #'valign-mode))

(use-package leetcode
    :config
    (setq leetcode-save-solutions t
          leetcode-prefer-language "cpp"
          leetcode-prefer-sql "mysql"
          leetcode-directory "~/workground/Leetcode/"))


;; (server-start)
(use-package org
  :hook
  (org-mode . turn-on-visual-line-mode)
  :config
  ; Tags with fast selection keys
  (setq org-tag-alist (quote ((:startgroup)
                              ("@office" . ?o)
                              ("@field" . ?f)
                              (:endgroup)
                              ("personal" . ?p)
                              ("work" . ?w)
                              ("cancelled" . ?c)
                              ("read" . ?r)
                              ("browse" . ?b)
                              ("flagged" . ??))))
  ; Allow setting single tags without the menu
  (setq org-fast-tag-selection-single-key (quote expert))
  ; For tag searches ignore tasks with scheduled and deadline dates
  (setq org-agenda-tags-todo-honor-ignore-options t)
  ;; (require 'org-bars)
  ;; (add-hook 'org-mode-hook #'org-bars-mode)
  (setq org-startup-folded "folded")
  (require 'org-ref)
  (setq reftex-default-bibliography '("~/Documents/2021/bibliography/references.bib"))
  (setq org-ref-bibliography-notes "~/Documents/2021/bibliography/notes.org"
        org-ref-default-bibliography '("~/Documents/2021/bibliography/references.bib")
        org-ref-pdf-directory "~/Documents/2021/bibliography/bibtex-pdfs/")

  ;; Capture templates for links to pages having [ and ]
  ;; characters in their page titles - notably ArXiv
  ;; From https://github.com/sprig/org-capture-extension
  (require 'org-protocol)
  (defun transform-square-brackets-to-round-ones(string-to-transform)
    "Transforms [ into ( and ] into ), other chars left unchanged."
    (concat
     (mapcar #'(lambda (c) (if (equal c ?\[) ?\( (if (equal c ?\]) ?\) c))) string-to-transform)))
  (setq org-capture-templates `(
                                ("p" "Protocal" entry (file+headline ,(concat "~/Documents/2021/" (format-time-string "%Y%m%d") ".org") "arxiv")
                                 "* [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n \n%i\n\n\n\n%?")
                                ("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes_" (shell-command-to-string "date +%F__%H-%M-%S_%Z")) "Inbox")
                                 "* %^{Title_and_tag}\n [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n")
                                ("w" "Web site" entry (file+headline ,(concat "~/Documents/2021/" (format-time-string "%Y%m%d") ".org") "arxiv")
                                 "* %a :website:\n\n%U %?\n\n%:initial")
                                ("c" "Captured" entry (file+headline ,(concat "~/Documents/2021/" (format-time-string "%Y%m%d") ".org") "arxiv")
                                 "* %t %:description\nlink: %l \n\n%i\n" :prepend t :empty-lines-after 1)
                                ("n" "Captured Now!" entry (file+headline ,(concat "~/Documents/2021/" (format-time-string "%Y%m%d") ".org") "arxiv")
                                 "* %t %:description\nlink: %l \n\n%i\n" :prepend t :emptry-lines-after 1 :immediate-finish t)
                                )))

;; "* %^{Title_and_tag}\nSource: [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
