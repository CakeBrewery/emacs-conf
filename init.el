(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq vc-follow-symlinks t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8)
(setq coding-system-system-for-write 'utf-8)
(setq sentence-end-double-space nil)
(setq default-fill-column 80)
(setq initial-scratch-message "Welcome to Emacs")

(require 'package)

(setq package-enable-at-startup nil)
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(unless (package-installed-p 'evil)
	(package-refresh-contents)
	(package-install 'evil))

(require 'use-package)
(require 'evil)
(evil-mode 1)
(global-linum-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (multi-term which-key avy counsel swiper use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package swiper :ensure t)
(use-package counsel :ensure t)
(use-package multi-term :ensure t)

(setq multi-term-program "/bin/bash")

(defun run-command-in-new-frame(command)
  (select-frame (make-frame))
  (funcall #'command))

(defun multi-term-new-window()
  (interactive)
  (let ((buf (multi-term)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(use-package general :ensure t
  :config
  (general-define-key "C-'" 'avy-goto-word-1)
  (general-define-key
   "C-s" 'swiper
   "M-x" 'counsel-M-x
  )
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   "'" '(lambda() (interactive) (multi-term-new-window) :which-key "multi-term")
   "b" 'ivy-switch-buffer
   "/" 'counsel-git-grep
   "f" '(:ignore t :which-key "files")
   "ff" 'counsel-find-file
   "fr" 'counsel-recentf
   "p" '(:ignore t :which-key "project")
   "pf" 'counsel-git
   )
)
 
(use-package avy :ensure t
  :commands (avy-goto-word-1)
)

;; Font
(set-face-attribute 'default nil
		    :family "Source Code Pro"
		    :height 100 
		    :weight 'normal
		    :width 'normal)

;; disable menu bar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
