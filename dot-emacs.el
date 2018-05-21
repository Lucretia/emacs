(require 'package)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Custom ------------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ctags-update ctags telephone-line hlinum spacemacs-theme ada-mode)))
 '(which-func-format
   (quote
    ((:propertize which-func-current local-map
                  (keymap
                   (mode-line keymap
                              (mouse-3 . end-of-defun)
                              (mouse-2 .
                                       #[0 "e\300=\203  ^@\301 \207~\207"
                                           [1 narrow-to-defun]
                                           2 nil nil])
                              (mouse-1 . beginning-of-defun)))
                  face which-func mouse-face mode-line-highlight help-echo "mouse-1: go to beginning
mouse-2: toggle rest visibility
mouse-3: go to end"))))
 '(which-function-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :background "#292b2e" :foreground "#b2b2b2" :weight bold :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(mode-line ((t (:background "dark violet" :foreground "lemon chiffon" :box (:line-width 1 :color "#5d4d7a")))))
 '(mode-line-buffer-id ((t (:inherit bold :foreground "white"))))
 '(mode-line-inactive ((t (:background "#292b2e" :foreground "#b2b2b2" :box (:line-width 3 :color "#5d4d7a")))))
 '(region ((t (:background "dark olive green" :foreground "white")))))

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Common ------------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
;; Set the default window dimensions
(when window-system (set-frame-size (selected-frame) 124 46))
(set-frame-size (selected-frame) 124 46)

;; Don't wrap the lines, ever!
(setq-default truncate-lines t)

;; don't show the startup screen.
(setq inhibit-startup-screen t)

;; Give me line/column numbers all the time.
(column-number-mode 1)
(line-number-mode 1)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; Delete all trailing spaces in the buffer before saving, useful for Ada.
;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable the horizontal scroll bar.
(horizontal-scroll-bar-mode)

;; Turn on syntax highlighting.
(global-font-lock-mode t)
;; enable syntax highlighting
;;(require 'font-lock)

;; Turn on text highlighting.
(transient-mark-mode t)

;; Turn on line numbers.
(global-linum-mode)

;; Highlight the current line.
(hlinum-activate)
(global-hl-line-mode)

;; Want Unicode.
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Mouse bindings ----------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Key bindings ------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------

;; cycle through buffers with Ctrl-Tab (like Firefox)
(global-set-key (kbd "<C-tab>") 'bury-buffer)

;; Set the keybinding to jump to line.
(global-set-key [(control c) (control g)] 'goto-line)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Themes ------------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(load-theme 'spacemacs-dark t t)
(enable-theme 'spacemacs-dark)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Powerline ---------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(require 'telephone-line)
(require 'telephone-line-segments)
(require 'telephone-line-separators)

(setq telephone-line-primary-left-separator 'telephone-line-identity-left
      telephone-line-secondary-left-separator 'telephone-line-identity-hollow-left
      telephone-line-primary-right-separator 'telephone-line-identity-right
      telephone-line-secondary-right-separator 'telephone-line-identity-hollow-right)
(setq telephone-line-lhs
      '((evil   . (telephone-line-major-mode-segment
                   telephone-line-evil-tag-segment))
        (accent . (telephone-line-misc-info-segment
                   telephone-line-flycheck-segment
                   telephone-line-vc-segment
                   telephone-line-erc-modified-channels-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil    . ())
        (accent . (telephone-line-minor-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))

(setq telephone-line-height 27
      telephone-line-evil-use-short-tag t)

(telephone-line-mode 1)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- CTags -------------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(setq path-to-ctags "/usr/bin/ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

;; ----------------------------------------------------------------------------------------------------------------------
;; -- CTags-update ------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(require 'ctags-update)
(setq ctags-update-prompt-create-tags nil)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Auto-complete -----------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/vendor/auto-complete")
(add-to-list 'load-path "~/.emacs.d/lisp/vendor/fuzzy-el")

(require 'fuzzy)
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-mode-map (kbd "TAB") nil)
(define-key ac-completing-map (kbd "TAB") nil)
(define-key ac-completing-map [tab] nil)
(add-hook 'after-init-hook 'global-auto-complete-mode)

(setq ac-delay -1.0)

;; Keys
(define-key ac-mode-map (kbd "C-SPC") 'auto-complete)
;;(ac-set-trigger-key "C-SPC")

;; Use cursor keys within the drop down menu.
(setq ac-use-menu-map t)
(define-key ac-menu-map "<DOWN>" 'ac-next)
(define-key ac-menu-map "<UP>" 'ac-previous)

;; Select the complete and finish.
(define-key ac-completing-map [return] 'ac-complete)

;; Colours
(custom-set-faces
 '(ac-etags-candidate-face ((t (:inherit ac-candidate-face :foreground "gainsboro"))))
 '(ac-etags-selection-face ((t (:inherit ac-selection-face :background "dark olive green" :foreground "white")))))

;; ----------------------------------------------------------------------------------------------------------------------
;; -- AC-ETags ----------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/vendor/ac-etags")

(require 'ac-etags)

(custom-set-variables
 '(ac-etags-requires 1))

(eval-after-load "etags"
  '(progn
     (ac-etags-setup)))

(add-hook 'ada-mode-hook 'ac-etags-ac-setup)
;;(add-hook 'after-init-hook 'ac-etags-ac-setup)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- AC-ISpell ---------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/vendor/ac-ispell")

(require 'ac-ispell)
;; Completion words longer than 4 characters

(custom-set-variables
 '(ac-ispell-fuzzy-limit 2)
 '(ac-ispell-requires 4))

(eval-after-load "auto-complete"
  '(progn
     (ac-ispell-setup)))

(add-hook 'after-init-hook 'ac-ispell-ac-setup)

;; ----------------------------------------------------------------------------------------------------------------------
;; -- Ada mode ----------------------------------------------------------------------------------------------------------
;; ----------------------------------------------------------------------------------------------------------------------
(defun my-ada-mode-hook ()
  ;; Show the current function in the status bar
  (which-function-mode t)

  (custom-set-variables
   '(ada-indent-label 0))

  ;; Allow expanding and collapsing blocks.
  ;;(outline-minor-mode)

  ;; Don't insert tabs when indenting!
  (setq-default indent-tabs-mode nil)

  ;; Set up the case exceptions file.
  (setq ada-case-exception-file "~/.emacs.d/ada/case_exceptions")
  (ada-case-read-all-exceptions)

  ;; Set up custom TAGS files for auto-completion.
  (setq tags-table-list
	'("~/opt/free-ada-6.4.0/lib/gcc/x86_64-pc-linux-gnu/6.4.0/adainclude/TAGS"
          "~/opt/free-ada-6.4.0/include/gnat_util/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_gmp.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_iconv.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_postgres.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_python.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_readline.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_sqlite.static/TAGS"
          "~/opt/free-ada-6.4.0/include/gnatcoll/gnatcoll_xref.static/TAGS"
	  "~/opt/ahven/TAGS"))

  (ctags-auto-update-mode)

  ;; Turn on autocompletion using CTags
  (add-to-list 'ac-sources 'ac-source-etags)

  ;; Turn on spell checking
  (flyspell-mode 1)
  (ispell-change-dictionary "british")

  ;; Delete all trailing spaces in the buffer before saving, useful for Ada.
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
)
(add-hook 'ada-mode-hook 'my-ada-mode-hook)
(add-hook 'ada-mode-hook  'turn-on-ctags-auto-update-mode)

;;(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
