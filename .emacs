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

;===========================
;     MISC KEY BINDINGS     
;===========================

(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "C-c C-r") 'align-regexp)
(global-set-key (kbd "C-c C-g") 'goto-line)
(global-set-key [f7] 'shell)
(global-set-key (kbd "C-c x") 'compile)
;(lookup-key (current-global-map) (kbd "C-c x")) ;;create compile shorcut

;=====================
;     MISC CONFIG     
;=====================

(column-number-mode 1)
(show-paren-mode 1)
(blink-cursor-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
;; Settings for the Emacs GUI
(when window-system
  (set-cursor-color "green")
  (set-background-color "gray13")
  (set-foreground-color "white")
)
;; set default major mode to text mode instead of Fundamental
(setq-default major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'text-mode-hook 'flyspell-mode)
(setq auto-mode-alist ;;make .h files defalut to c++ mode
      (cons '("\\.h\\'" . c++-mode) auto-mode-alist)) 

;========================
;     SPECIFIC MODES     
;========================

;; org mode
(add-hook 'org-mode-hook
	  (lambda() (local-set-key (kbd "C-c a") 'org-agenda)))

;; octave mode
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
    (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
    (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; php-mode
;; syntax highlighting for php code
(global-font-lock-mode 1)
(require 'php-mode)
(setq auto-mode-alist
  (append '(("\.php$" . php-mode)
            ("\.module$" . php-mode))
              auto-mode-alist))

;; Set TODO to be yellow in programming languages

;; highlight todo for c like programming languages
;; for emacs 23
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(TODO\\):" 1 
				       '(:background "yellow"
					 :foreground "black") t)))))

;; highlight todo for python programming language
;; for emacs 23
(add-hook 'python-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(TODO\\):" 1 
				       '(:background "yellow"
					 :foreground "black") t)))))

;; Only works for emacs 24
;; (add-hook 'prog-mode-hook
;; 	  (lambda ()
;; 	    (font-lock-add-keywords nil
;; 				    '(("\\<\\(TODO\\):" 1 
;; 				       '(:background "yellow"
;; 					 :foreground "black") t)))))

;=========================
;     WINDOW MOVEMENT     
;=========================

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
;; (require 'fill-column-indicator)
;; (add-hook 'after-change-major-mode-hook 'fci-mode)




;===================
;     FUNCTIONS     
;===================

;; insert (comment-start) ASSERT: 
(defun insert_assert()
  (interactive)
  (insert comment-start "ASSERT: ") (indent-for-tab-command)
)

;Pre:  C-c n 
;Post: Pre and Post sections are placed and commented out, cursor is
;      moved to end of first line
(defun pre_post ()
  (interactive)
  (insert comment-start "PRE:  " comment-end) (indent-for-tab-command)
  (insert "\n" comment-start "POST: " comment-end) (indent-for-tab-command)
  (previous-line) (move-end-of-line 1) ;;the '1' is for current line
  (message "If you want different comment characters, use C-c c\nmanually set goal column for comments by moving to the desired column and typing  C-x ;")) 

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

;;;;End Stuff for Comments;;;;

;Pre:  M-{
;Post: Open and close curly brackets are placed, the cursor is put in
;      the middle
(defun open_close_curly ()
  (interactive)
  (insert "{\n\n}") (indent-for-tab-command) 
  (previous-line)  (indent-for-tab-command))
 

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

;Pre:  C-c e
;Post: A cerr statement is placed, cursor moved to middle
(defun insert_cerr_line()
  (interactive)
  (indent-for-tab-command)
  (insert "cerr << \"")(insert (buffer-name) " ")
  (insert (what-line))(insert ": \" << endl;")
  (backward-char)(backward-char)(backward-char)(backward-char)(backward-char)
  (backward-char)(backward-char)(backward-char)(backward-char)(backward-char))


;Pre:  count is an integer > 0, character is some string
;Post: 
(defun insert-string (count string)
  (setq i 0)
  (while (< i count)
    (insert string)
    (setq i (+ 1 i))
    )
  )

;Pre:  C-c f
;Post: A flower box is inserted and the cursor is placed in the middle
(defun flower_box()
  (setq title  (read-from-minibuffer "Title of pretty flowerbox? "))
  (interactive)

  (indent-for-tab-command) (insert comment-start)
  (insert-string (+ (length title) 10) "=")
  (insert "\n" comment-end)

  (indent-for-tab-command) (insert comment-start)
  (insert-string 5 " ") (insert title) (insert-string 5 " ")  
  (insert comment-end "\n")

  (indent-for-tab-command) (insert comment-start)
  (insert-string (+ (length title) 10) "=")
  (insert "\n" comment-end))


;===============================
;     FUNCTION KEY BINDINGS     
;===============================
(global-set-key (kbd "C-c a") 'insert_assert)
(global-set-key (kbd "C-c n") 'pre_post)
(lookup-key (current-global-map) (kbd "C-c n"))
(global-set-key (kbd "C-c c") 'set_comment_characters)
(lookup-key (current-global-map) (kbd "C-c c"))
(global-set-key (kbd "M-{") 'open_close_curly)
(lookup-key (current-global-map) (kbd "M-{"))
(global-set-key (kbd "C-x C-l") 'LaTeX_header)
(lookup-key (current-global-map) (kbd "C-x C-l"))
(global-set-key (kbd "C-c e") 'insert_cerr_line)
(lookup-key (current-global-map) (kbd "C-c e"))
(global-set-key (kbd "C-c f") 'flower_box)
(lookup-key (current-global-map) (kbd "C-c f"))


;;Set theme to be 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
