;; install the color theme
(add-to-list 'load-path "/Users/rbolkey/.emacs.d/elpa-to-submit/color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme" 
  '(progn
     '(color-theme-initialize)
     (if (window-system)
	 (color-theme-arjen)
	 (color-theme-arjen))))

;; require or autoload highlight-parentheses
(autoload 'hightlight-parentheses-mode "highlight-parentheses" nil t)
(add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
                    (if (boundp 'autopair-handle-action-fns)
                        autopair-handle-action-fns
                      '(autopair-default-handle-action))
                    '((lambda (action pair pos-before)
                        (hl-paren-color-update)))))))

(defun lisp-enable-highlight-parentheses-hook ()
  (when (locate-library "highlight-parentheses")
      (require 'highlight-parentheses)
      (highlight-parentheses-mode)))

(add-hook 'clojure-mode-hook          'lisp-enable-highlight-parentheses-hook)
(add-hook 'slime-repl-mode-hook       'lisp-enable-highlight-parentheses-hook)
(add-hook 'emacs-lisp-mode-hook       'lisp-enable-highlight-parentheses-hook)
(add-hook 'lisp-mode-hook             'lisp-enable-highlight-parentheses-hook)
(add-hook 'lisp-interaction-mode-hook 'lisp-enable-highlight-parentheses-hook)


;; require or autoload paredit-mode
(autoload 'paredit-mode "paredit" nil t)
(defun lisp-enable-paredit-hook ()
  (when (locate-library "paredit")
      (require 'paredit)
      (paredit-mode 1)))

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
