(setq auto-mode-alist ;;make .h files defalut to c++ mode
      (cons '("\\.h\\'" . c++-mode) auto-mode-alist)) 

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;========================
;     SPECIFIC MODES     
;========================
;PRE:  .bash_aliases file is open.
;POST: Sets the major mode for .bash_aliases file to be sh-mode
(add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . sh-mode))

;; MY KEYS MODE
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")
(define-key my-keys-minor-mode-map (kbd "C-c C-r") 'align-regexp)
(define-key my-keys-minor-mode-map (kbd "M-;") 'comment-dwim)
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)
(my-keys-minor-mode 1)

;; IDO MODE
(require 'ido)
(ido-mode t)

;; TEXT MODE
;; set default major mode to text mode instead of Fundamental
(setq-default major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; ORG MODE
(add-hook 'org-mode-hook
	  (lambda() (local-set-key (kbd "C-c a") 'org-agenda)))

(setq org-log-done t)
(setq org-tag-alist '((:startgroup . nil)
		      ("@SCHOOL" . ?s) ("@HOME" . ?h)
		      (:endgroup . nil)
		      ("COMPUTER" . ?c) ("READ" . ?r)))
(setq org-use-fast-todo-selection t)
(setq org-tags-column -70)

;; ORG TODO SEQUENCE
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN PROGRESS(p!)" "|" "DONE(d!)")))

;; OCTAVE MODE
;; (autoload 'octave-mode "octave-mod" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (add-hook 'octave-mode-hook
;;           (lambda ()
;;             (abbrev-mode 1)
;;             (auto-fill-mode 1)
;;             (if (eq window-system 'x)
;;                 (font-lock-mode 1))))

;; LUA MODE
;; (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;;     (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
;;     (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; PHP-MODE
;; syntax highlighting for php code
;; (global-font-lock-mode 1)
;; (require 'php-mode)
;; (setq auto-mode-alist
;;   (append '(("\.php$" . php-mode)
;;             ("\.module$" . php-mode))
;;               auto-mode-alist))
