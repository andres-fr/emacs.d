;; TAKE A LOOK AT THIS: http://dasnacl.de/

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)

(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)

(require 'init-recentf)
(require 'init-ido)
(require 'init-hippie-expand)
(require 'init-auto-complete)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-mmm)

(require 'init-editing-utils)
(require 'init-whitespace)
(require 'init-fci)

(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-github)

(require 'init-compile)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-php)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-elm)
(require 'init-ruby-mode)
(require 'init-rails)
(require 'init-sql)

(require 'init-paredit)
(require 'init-lisp)
(require 'init-slime)
(unless (version<= emacs-version "24.2")
  (require 'init-clojure)
  (require 'init-clojure-cider))
(require 'init-common-lisp)

(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

(require 'init-dash)
(require 'init-ledger)
;; Extra packages which don't require any configuration

(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
  (error "Please move init-local.el to ~/.emacs.d/lisp"))
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(add-hook 'after-init-hook
          (lambda ()
            (message "init completed in %.2fms"
                     (sanityinc/time-subtract-millis after-init-time before-init-time))))


(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ANDRES CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;; some useful global keybindings
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<up>") 'shrink-window)
(global-set-key (kbd "S-C-<down>") 'enlarge-window)
(global-set-key (kbd "C--") 'delete-backward-char)
(global-set-key (kbd "M--") 'backward-kill-word)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "C-, C-,") 'replace-string)
(global-set-key (kbd "C-, C-.") 'replace-regexp)
(global-set-key (kbd "C-, C-c") 'comment-region)
(global-set-key (kbd "C-, C-u") 'uncomment-region)
(delete-selection-mode 0)
(defun select-current-word ()
  (interactive)
  (backward-word) (mark-word))
(global-set-key (kbd "C-, C-w") 'select-current-word)
;;; deactivate "too smart" features
;(browse-kill-ring-mode)





;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;SMOOTH SCROLLING
;; ;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 7)

;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;COLUMN ENFORCE MODE LINE SIZE 80
;; ;;;;;;;;;;;;;;;;;;;;;;;;
(defun column-enforce-mode-toggle-if-applicable ()
  (if column-enforce-mode
      (column-enforce-mode -1)
    (when (derived-mode-p 'prog-mode)
      (column-enforce-mode t))))

(define-global-minor-mode global-column-enforce-mode column-enforce-mode
  column-enforce-mode-toggle-if-applicable)
(require 'column-enforce-mode)
(global-column-enforce-mode t)

;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;SND CONFIG
;; ;;;;;;;;;;;;;;;;;;;;;;;;
(load "inf-snd.el")
(set-default 'auto-mode-alist
	     (append '(("\\.rbs$" . snd-ruby-mode)
                       ("\\.snd7$" . snd-scheme-mode))
		     auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;MINIMAL RUBY CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-ruby-clear-repl ()
  (interactive)
  (save-excursion
    (set-buffer inf-ruby-buffer)
    (erase-buffer) 
    (ruby-send-block)
    ))

(defun my-ruby-send-paragraph ()
  (interactive)
  (save-excursion
    (let ((beg (progn (backward-paragraph)(line-beginning-position)))
	  (end (progn (forward-paragraph)(line-beginning-position))))
      (ruby-send-region beg end))))


(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-l") 'my-ruby-clear-repl)
            (local-set-key (kbd "C-M-<return>") 'my-ruby-send-paragraph)
            (local-set-key (kbd "C-, <C-return>") 'ruby-send-buffer)
            ))

;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;MINIMAL PYTHON CONFIG
;; ;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun py-clear-helping-function ()
;;   "helping function for py-clear-repl"
;;   (let ((comint-buffer-maximum-size 0))
;;     (comint-truncate-buffer)))
;; (defun py-clear-repl ()
;;   "clears the Python REPL"
;;   (interactive)
;;   (save-excursion
;;     (set-buffer (concat "*" py-which-bufname "*"))
;;     (py-clear-helping-function)
;;     (end-of-buffer)))


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; OCTAVE/MATLAB https://www.gnu.org/software/octave/doc/v4.0.1/Using-Octave-Mode.html#Using-Octave-Mode
;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))


(defun my-octave-clear-repl ()
  (interactive)
  (save-excursion
    (set-buffer "*Inferior Octave*")
    (erase-buffer)))

(defun my-octave-send-paragraph ()
  (interactive)
  (save-excursion
    (let ((beg (progn (backward-paragraph)(line-beginning-position)))
	  (end (progn (forward-paragraph)(line-beginning-position))))
      (octave-send-region beg end))))


(add-hook 'octave-mode-hook
          (lambda ()
            (local-set-key (kbd "C-, <C-return>") 'my-octave-send-paragraph)
            (local-set-key (kbd "C-M-<return>") 'octave-send-line)
            (local-set-key (kbd "C-c M-l") 'my-octave-clear-repl)
            (local-set-key "\C-m" (key-binding "\C-j")) ;;;RET-behaves-as-LFD 
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; SCALA CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-ensime-send-string (str)
  (with-current-buffer ensime-inf-buffer-name 
    (goto-char (point-max))
    (comint-send-string nil ":paste\n")
    (comint-send-string nil str)
    (comint-send-string nil "\n")
    (comint-send-eof)))

(defun my-ensime-eval-last-paragraph ()
  (interactive)
  ;;  schedule return to initial pos after 0.3 seconds
  (let ((before-pos (point)))
    (run-at-time "0.3 sec" nil #'(lambda (x)
                                   ;;(goto-char (point))
                                   (deactivate-mark)) before-pos)
    ;; find last paragraph tail
    (beginning-of-line)
    (while (or  (<= (point) (point-min))
                (looking-at "\\s-*$")) ;;regexp for "whitespace-only line"
      (next-line -1))
    ;; find last paragraph beginning
    (while (or  (<= (point) (point-min))
                (not (looking-at "\\s-*$"))) ;;regexp for "whitespace-only line"
      (next-line -1))
    (next-line)
    ;; mark
    (set-mark (point))
    ;; find paragraph end
    (while (not (looking-at "\\s-*$")) (next-line)) 
    (my-ensime-send-string
     (buffer-substring-no-properties (region-beginning) (region-end)))))

(defun my-ensime-eval-current-line ()
  (interactive)
  (let ((before-pos (point)))
    (beginning-of-line)
    (set-mark (point))
    (end-of-line)
    (run-at-time "0.3 sec" nil #'(lambda (x)
                                   (goto-char x)
                                   (deactivate-mark)) before-pos)
    (my-ensime-send-string (buffer-substring-no-properties (region-beginning) (region-end)))
    ))


(defun my-ensime-clear-repl ()
  (interactive)
  (with-current-buffer ensime-inf-buffer-name
    (erase-buffer)
    (comint-send-input)))




(add-hook 'ensime-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-l") #'my-ensime-clear-repl)
            (local-set-key (kbd "C-, <C-return>") #'my-ensime-eval-last-paragraph)
            (local-set-key (kbd "C-M-<return>") #'my-ensime-eval-current-line)))


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; RAINBOW DELIMITERS
;;;;;;;;;;;;;;;;;;;;;;;;
;; '(rainbow-delimiters-depth-1-face ((t (:foreground "yellow"))))
;; '(rainbow-delimiters-depth-2-face ((t (:foreground "dark gray"))))
;; '(rainbow-delimiters-depth-3-face ((t (:foreground "deep pink"))))
;; '(rainbow-delimiters-depth-4-face ((t (:foreground "green yellow"))))
;; '(rainbow-delimiters-depth-5-face ((t (:foreground "deep sky blue"))))
;; '(rainbow-delimiters-depth-6-face ((t (:foreground "yellow1"))))
;; '(rainbow-delimiters-depth-7-face ((t (:foreground "gold3"))))
;; '(rainbow-delimiters-depth-8-face ((t (:foreground "orange3"))))
;; '(rainbow-delimiters-depth-9-face ((t (:foreground "DarkOrange4"))))



;;;;;;;;;;;;;;;;;;;;;;;;
;;; SHELL CONFIGURATION
;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-clear-shell ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(defun my-shell-hook ()
  (local-set-key (kbd "C-c M-l") 'my-clear-shell))
(add-hook 'shell-mode-hook 'my-shell-hook)



;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; PYTHON CONFIGURATION
;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun py-check-execute-string (command-to-print)
;;   "just a check function for pedagogic purposes"
;;   (py-execute-string
;;    (concat "print('" (concat "EXECUTE>>> print(" command-to-print) ")')")))
;; (defun py-check-execute-region (beg end)
;;   "just a check function for pedagogic purposes"
;;   (let ((command-to-print (buffer-substring beg end)))
;;     (py-execute-string
;;      (concat "print('" (concat "EXECUTE>>> " command-to-print) "')"))))

;;                                         ; defining some useful functions
;; (defun py-execute-line ()
;;   "sends the current line to the Python interpreter."
;;   (interactive)
;;   (save-excursion
;;     (let ((beg (line-beginning-position))
;; 	  (end (line-end-position)))
;;                                         ;(py-check-execute-region beg end) ;; for pedagogical purposes
;;       (py-execute-region beg end))))
;; (defun py-print-execute-line ()
;;   "wraps the current line with print(<LINE>) and sends all to the interpreter."
;;   (interactive)
;;   (save-excursion
;;     (let* ((beg (line-beginning-position))
;; 	   (end (line-end-position))
;; 	   (raw-line (buffer-substring-no-properties beg end))
;; 	   (uncommented-line (first (split-string raw-line "#"))))
;;                                         ;(py-check-execute-string uncommented-line) ;; for pedagogical purposes
;;       (py-execute-string (concat "print(" uncommented-line ")")))))
;; (defun py-execute-paragraph ()
;;   "sends the current paragraph to the Python interpreter."
;;   (interactive)
;;   (save-excursion 
;;     (let ((beg (progn (backward-paragraph)(line-beginning-position)))
;; 	  (end (progn (forward-paragraph)(line-beginning-position))))
;;       (py-execute-region beg end))))

;; (defun py-run-current-file-with-shell ()
;;   (interactive)
;;   (shell-command (concat "python3 " (file-name-base) ".py")))

;; (defun py-clear-helping-function ()
;;   "helping function for py-clear-repl"
;;   (let ((comint-buffer-maximum-size 0))
;;     (comint-truncate-buffer)))
;; (defun py-clear-repl ()
;;   "clears the Python REPL"
;;   (interactive)
;;   (save-excursion
;;     (set-buffer (concat "*" py-which-bufname "*"))
;;     (py-clear-helping-function)
;;     (end-of-buffer)))

;; ;; initialization settings for python mode
;;                                         ; autocompletion and help (see C-h m)
;; (defun my-py-hook ()
;;   (company-mode -1)
;;   (auto-complete-mode)        
;;   (jedi:ac-setup)             
;;   (electric-pair-mode)        
;;   (rainbow-delimiters-mode)   
;;   (column-enforce-mode)
;;   (local-set-key (kbd "C-c <C-return>") 'py-execute-region)
;;   (local-set-key (kbd "<C-M-return>") 'py-execute-line)
;;   (local-set-key (kbd "C-. <C-return>") 'py-print-execute-line)
;;   (local-set-key (kbd "<C-return>") 'py-execute-paragraph)
;;   (local-set-key (kbd "<M-return>") 'py-run-current-file-with-shell)
;;   (local-set-key (kbd "C-c M-l") 'py-clear-repl))
;; (add-hook 'python-mode-hook 'my-py-hook)

;; ;; initialization settings for the python repl
;; (defun my-py-shell-hook ()
;;   (local-set-key (kbd "<up>") 'comint-previous-matching-input-from-input)
;;   (local-set-key (kbd "<down>") 'comint-next-matching-input-from-input)
;;   (local-set-key (kbd "C-c M-l") 'py-clear-repl))
;; (add-hook 'py-shell-hook  'my-py-shell-hook)




;;;;;;;;;;;;;;;;;;;;;;;;
;;; C/C++ CONFIGURATION
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl)

(cl-defun my-compile-command
    ( &optional (eval? t) (compiler "gcc") (c-standard "-std=c11")
		(warnings "-Wall -Wextra"))
  "Returns a string with a bash command that compiles to a file named like the 
   current buffer, and under the same directory.
   Arguments:
    -eval?: t by default, evals the program after compiling. Results are shown in the
     *Shell Command Output* buffer.
    -compiler, c-standard, warnings: optional flags for the compiler"
  (interactive)
  (let* ((file-name (buffer-file-name))
	 (outname  (file-name-sans-extension (buffer-name)))
	 (eval-after-compile (when eval? (concat " && ./" outname))))
    (concat compiler " " c-standard " " warnings " "
	    file-name " -o " outname
	    eval-after-compile)))
(defun my-c-compile-command ()
  "inserts the compile&eval command given by (my-compile-command)
   into the *shell* buffer, but doesn't evaluate it"
  (interactive)
  (let ((orig (buffer-name))
	(command (my-compile-command)))
    (switch-to-buffer "*shell*")
    (end-of-buffer)
    (insert command)
    (switch-to-buffer orig)))
(defun my-c++-compile-command ()
  "inserts the compile&eval command given by (my-compile-command)
   into the *shell* buffer, but doesn't evaluate it"
  (interactive)
  (let ((orig (buffer-name))
	(command (my-compile-command t "g++" "-std=c++14")))
    (switch-to-buffer "*shell*")
    (end-of-buffer)
    (insert command)
    (switch-to-buffer orig)))

(defun my-c-compile-buffer ()
  "alias for my-compile-buffer"
  (interactive)
  (shell-command (my-compile-command)))
(defun my-c++-compile-buffer ()
  "basic c++ usage of my-compile-buffer"
  (interactive)
  (shell-command (my-compile-command t "g++" "-std=c++14")))

(setf my-c-greeting (concat "printf "
		            "\"**********************************************\n"
			    "*         *Shell Command Output*             *\n"
			    "**********************************************\n"
			    "*  PRESS C-RET IN YOUR C FILE TO COMPILE IT  *\n"
			    "*   THE TERMINAL OUTPUT WILL BE SHOWN HERE   *\n"
			    "**********************************************\n\""))
                                        ; add the custom c functions to the custom c hook
(defun my-c-hook ()
  (shell-command my-c-greeting)
  (split-window-horizontally)
  (save-excursion
    (other-window 1)
    (switch-to-buffer "*Shell Command Output*")
    (split-window-vertically)
    ;;(enlarge-window (/ (window-height (next-window)) 2))
    (other-window 1)
    (shell)
    (switch-to-buffer "*shell*")
    (other-window 1))
  (local-set-key (kbd "C-. <C-return>") 'my-c-compile-command)
  (local-set-key (kbd "<C-return>") 'my-c-compile-buffer))
                                        ; add the custom c++ functions to the custom c++ hook
(defun my-c++-hook ()
  (local-set-key (kbd "C-. C-c") 'my-c++-compile-command)
  (local-set-key (kbd "C-. C-.") 'my-c++-compile-buffer))

;;; add the custom c hook to the main c hook
; (add-hook 'c-initialization-hook 'my-c-hook)
;;; add the custom c++ hook to the main c++ hook
; (add-hook 'c++-mode-hook 'my-c++-hook)



(put 'erase-buffer 'disabled nil)
