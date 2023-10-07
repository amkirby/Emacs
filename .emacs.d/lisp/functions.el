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
