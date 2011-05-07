;; install the color theme
(add-to-list 'load-path "/Users/rbolkey/.emacs.d/elpa-to-submit/color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme" 
  '(progn
     '(color-theme-initialize)
     (if (window-system)
	 (color-theme-charcoal-black)
	 (color-theme-emacs-nw))))

;; require or autoload highlight-parentheses
(defun lisp-enable-highlight-parentheses-hook ()
  (highlight-parentheses-mode)
  (setq autopair-handle-action-fns
	(list 'autopair-default-handle-action
	      '(lambda (action pair pos-before)
		 (hl-paren-color-update)))))

(add-hook 'clojure-mode-hook          'lisp-enable-highlight-parentheses-hook)
(add-hook 'slime-repl-mode-hook       'lisp-enable-highlight-parentheses-hook)
(add-hook 'emacs-lisp-mode-hook       'lisp-enable-highlight-parentheses-hook)
(add-hook 'lisp-mode-hook             'lisp-enable-highlight-parentheses-hook)
(add-hook 'lisp-interaction-mode-hook 'lisp-enable-highlight-parentheses-hook)


;; require or autoload paredit-mode
(defun lisp-enable-paredit-hook () (paredit-mode 1))

(add-hook 'clojure-mode-hook          'lisp-enable-paredit-hook)
(add-hook 'slime-repl-mode-hook       'lisp-enable-paredit-hook)
(add-hook 'emacs-lisp-mode-hook       'lisp-enable-paredit-hook)
(add-hook 'lisp-mode-hook             'lisp-enable-paredit-hook)
(add-hook 'lisp-interaction-mode-hook 'lisp-enable-paredit-hook)

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))

(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
