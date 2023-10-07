;===========================
;     MISC KEY BINDINGS     
;===========================
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "C-c C-r") 'align-regexp)
(global-set-key (kbd "C-c C-g") 'goto-line)
(global-set-key [f7] 'shell)
(global-set-key (kbd "C-c x") 'compile)


;=========================
;     WINDOW MOVEMENT     
;=========================

;; set meta-arrows to move between buffers
(require 'windmove)
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c j") 'windmove-down)
