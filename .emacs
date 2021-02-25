(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-check-command "ghc -fno-code")
 '(package-selected-packages
   '(retrie ghc-imported-from haskell-emacs flymake-haskell-multi haskell-mode hackernews 2048-game evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-definition-face ((t (:inherit (Montserrat font-lock-function-name-face))))))
(require 'evil)
(evil-mode 1)
