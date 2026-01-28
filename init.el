;;; init.el --- Slightly opinionated default Emacs configuration

;;; Commentary:

;; This repository provides reasonable defaults of which to build a
;; personal Emacs configuration off.  It aims mainly to expose some of
;; the sticking points and non-obvious configurations that new users
;; might want to change.  While most of the configuration here will be
;; valuable to almost all users, they are slightly aligned with the
;; author's preferences.

;;; Code:

;; Define configuration variables
(defvar conf/fixed-pitch-font
  (font-spec :family "Monospace"  :weight 'regular :size 12.0))
(defvar conf/variable-pitch-font
  (font-spec :family "Sans Serif" :weight 'regular :size 12.0))

(defvar conf/backups-dir
  (expand-file-name "backups/"  user-emacs-directory))
(defvar conf/packages-dir
  (expand-file-name "packages/" user-emacs-directory))

;; Load use-package
(require 'package)
(require 'use-package)

(add-to-list 'load-path conf/packages-dir)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Configure core emacs
(use-package emacs
  :bind
  ("C-h"     . backward-delete-char)
  ("C-x C-k" . kill-current-buffer)
  ("C-x 9"   . bury-buffer)
  ("C-c r"   . eval-region)

  :custom-face
  (default        ((t (:font ,conf/fixed-pitch-font))))
  (fixed-pitch    ((t (:font ,conf/fixed-pitch-font))))
  (variable-pitch ((t (:font ,conf/variable-pitch-font))))

  :custom
  ;; Behavior
  (gc-cons-threshold (* 2 1024 1024))
  (ring-bell-function #'ignore)
  (use-short-answers 1)
  (tab-width 4)

  ;; Scrolling
  (auto-window-vscroll nil)
  (fast-but-imprecise-scrolling t)
  (scroll-conservatively 101)
  (scroll-margin 0)
  (scroll-preserve-screen-position t)

  ;; Bidirectional text
  (bidi-paragraph-direction 'left-to-right)
  (bidi-inhibit-bpa t)

  ;; Custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))

  ;; Files
  (large-file-warning-threshold (* 256 1024 1024))
  (make-backup-files nil)
  (backup-directory-alist `(("." . ,conf/backups-dir)))
  (auto-save-file-name-transforms `((".*" ,conf/backups-dir t)))

  ;; Minibuffer
  (read-file-name-completion-ignore-case t)
  (completion-category-overrides
   '((file (styles basic partial-completion))))

  ;; Windowing
  (switch-to-buffer-in-dedicated-window 'pop)
  (switch-to-buffer-obey-display-actions t)

  :config
  ;; Disabled modes
  (indent-tabs-mode -1)

  ;; Enabled modes
  (column-number-mode 1)
  (delete-selection-mode 1)
  (electric-pair-mode 1)
  (global-so-long-mode 1)
  (show-paren-mode 1)
  (visual-line-mode 1))

;; Configure packages
(use-package autorevert
  :custom
  (global-auto-revert-non-file-buffers t)
  :init
  (global-auto-revert-mode t))

(use-package compile
  :custom
  (compilation-scroll-output t))

(use-package dired
  :custom
  (dired-dwim-target t)
  (dired-kill-when-opening-new-dired-buffer t))

(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode)
  (conf-mode . display-line-numbers-mode)
  :custom
  (display-line-numbers-type 'visual)
  (display-line-numbers-width 3))

(use-package kmacro
  :bind-keymap
  ("C-c k" . kmacro-keymap))

(use-package modus-themes
  :ensure t
  :init
  (load-theme 'modus-operandi t))

(use-package whitespace
  :hook
  (prog-mode . whitespace-mode)
  (text-mode . whitespace-mode)
  (conf-mode . whitespace-mode)
  :custom
  (whitespace-style '(face tabs trailing)))

;; Load customizations
(load custom-file :noerror)

;;; init.el ends here
