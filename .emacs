(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes nil)
 '(font-use-system-font t)
 '(inhibit-startup-screen t))

;; Leaving this comment so that users can know how to use the .emacs.d
;; directory.
;;(add-to-list 'load-path "~/.emacs.d")

;; turns on auto-fill when ctrl-c q is pressed
(global-set-key (kbd "C-c q") 'auto-fill-mode)

;; shows column number on bottom
(column-number-mode 1)

; highlights opening and closing braces
(show-paren-mode 1)

;; php-mode
;; syntax highlighting for php code
(global-font-lock-mode 1)
(require 'php-mode)
(setq auto-mode-alist
  (append '(("\.php$" . php-mode)
            ("\.module$" . php-mode))
              auto-mode-alist))

;; set meta-arrows to move between buffers
(require 'windmove)
(windmove-default-keybindings 'meta)
(defvar real-keyboard-keys
  '(("<M-up>"    ."\M-[1;3A")
    ("<M-down>"  ."\M-[1;3B")
    ("<M-right>" ."\M-[1;3C")
    ("<M-left>"  ."\M-[1;3D"))
  "An assoc list of pretty key strings and their term equiv.")

(defun key (desc)
  (or (and window-system (read-kbd-macro desc))
      (or (cdr ( assoc desc real-keyboard-keys))
	  (read-kbd-macro desc))))

(global-set-key (key "<M-left>") 'windmove-left)
(global-set-key (key "<M-right>") 'windmove-right)
(global-set-key (key "<M-up>") 'windmove-up)
(global-set-key (key "<M-down>") 'windmove-down)

;; add fill column indicator
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)

;; Set TODO to be yellow in programming languages
;; Only works for emacs 24
(add-hook 'prog-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(TODO\\):" 1 
				       '(:background "yellow"
					 :foreground "black") t)))))

;; Settings for the Emacs GUI
(when window-system
  (set-cursor-color "green")
  (set-background-color "gray13")
  (set-foreground-color "white")
)

;; insert (comment-start) ASSERT: 
(defun insert_assert()
  (interactive)
  (insert comment-start "ASSERT: ") (indent-for-tab-command)
)
(global-set-key (kbd "C-c a") 'insert_assert)

;;(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; set default major mode to text mode instead of Fundamental
(setq-default major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;;Begin Stuff for Comments;;;;

;Pre:  C-c n 
;Post: Pre and Post sections are placed and commented out, cursor is
;      moved to end of first line
(defun pre_post ()
  (interactive)
  (insert comment-start "PRE:  " comment-end) (indent-for-tab-command)
  (insert "\n" comment-start "POST: " comment-end) (indent-for-tab-command)
  (previous-line) (move-end-of-line 1) ;;the '1' is for current line
  (message "If you want different comment characters, use C-c c\nmanually set goal column for comments by moving to the desired column and typing  C-x ;")) 
(global-set-key (kbd "C-c n") 'pre_post)
(lookup-key (current-global-map) (kbd "C-c n"))

;Pre:  C-c c
;      The new comment-start & comment-end characters are given by the
;      user when prompted
;Post: The variables for comment-start and comment-end are set
;      accordingly
(defun set_comment_characters()
  (interactive)
  (setq comment-start  (read-from-minibuffer "New comment-start character? "))
  (setq comment-end  (read-from-minibuffer "New comment-end character? "))
  (message "Comment characters set for current buffer"))
(global-set-key (kbd "C-c c") 'set_comment_characters)
(lookup-key (current-global-map) (kbd "C-c c"))

;;;;End Stuff for Comments;;;;

;Pre:  M-{
;Post: Open and close curly brackets are placed, the cursor is put in
;      the middle
(defun open_close_curly ()
  (interactive)
  (insert "{\n\n}") (indent-for-tab-command) 
  (previous-line)  (indent-for-tab-command))
(global-set-key (kbd "M-{") 'open_close_curly)
(lookup-key (current-global-map) (kbd "M-{"))
 
;Pre:  Control-x c
;Post: Compile shortcut produced
(global-set-key (kbd "C-x c") 'compile)
(lookup-key (current-global-map) (kbd "C-x c")) ;;create compile shorcut

;PRE:  
;POST: Asks for the title of the document and the author of the
;      document and creates the header for the document
(defun LaTeX_header (class title author)
  (interactive "MDocument Class: \nMTitle: \nMAuthor: ")
  (insert (concat "\\documentclass{" class "}\n"))
  (insert (concat "\\title{" title "}\n"))
  (insert (concat "\\author{" author "}\n"))
  (insert "\\date{\\today}")
  (insert "\n\n")
  (latex_tags "document")
  (insert "\\maketitle\n")
)
(global-set-key (kbd "C-x C-l") 'LaTeX_header)
(lookup-key (current-global-map) (kbd "C-x C-l"))

;PRE:  .bash_aliases file is open.
;POST: Sets the major mode for .bash_aliases file to be sh-mode
(add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . sh-mode))

;; Can be uncommented if <C - c> <C - t> does not do this already
;PRE:  
;POST: Creates the begin and end LaTeX tags for the user defined tag.
(defun latex_tags (tag)
  (interactive "MTag to create: ")
  (insert (concat "\\begin{" tag "}\n\n")) (indent-for-tab-command)
  (insert (concat "\\end{" tag "}")) (indent-for-tab-command)
  (previous-line) (indent-for-tab-command)
)
;; ;; binds Control-c Control-t to the latex_tags function
;; (global-set-key (kbd "C-c C-t") 'latex_tags)
;; (lookup-key (current-global-map) (kbd "C-c C-t"))

;;set theme to be 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )