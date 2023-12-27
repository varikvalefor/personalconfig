(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-highlight-face-groups 'default-faces)
 '(agda2-highlight-level 'none)
 '(agda2-program-args
   '("--ghc-flag=-package random"
     "--ghc-flag=-dynamic"
     "--ghc-flag=-O2"
     "-v3"
     "--ghc-flag=-package plegg"))
 '(global-ede-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(term+ gnu-apl-mode evil-nl-break-undo annotation eri 2048-game evil))
 '(semantic-mode t))

(require 'evil)
(evil-mode 1)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

(defun disable-all-themes ()
  "disable all active themes."
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defadvice load-theme (before disable-themes-first activate)
	  (disable-all-themes))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t 
   (:family "Courier New"
    :foundry "TMC "
    :slant normal
    :weight normal
    :height 97
    :width normal))))
 '(fixed-pitch ((t (:family "Courier New"))))
 '(line-number ((t (:inherit default))))
 '(variable-pitch ((t (:family "Comic Sans MS")))))



(global-font-lock-mode 0)
;; | ni'o snuti fa lo so'i broda cei nu la .varik. cu
;; mu'oi zoi. C-x C-c .zoi. sisti tu'a la'oi .EMACS.
;; .i la .varik. cu toldji lo nu lo broda cu snuti
(global-set-key (kbd "C-x C-c") nil)
