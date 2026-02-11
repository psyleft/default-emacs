;;; early-init.el --- Slightly opinionated default Emacs configuration

;;; Commentary:

;; This repository provides reasonable defaults of which to build a
;; personal Emacs configuration off.  It aims mainly to expose some of
;; the sticking points and non-obvious configurations that new users
;; might want to change.  While most of the configuration here will be
;; valuable to almost all users, they are slightly aligned with the
;; author's preferences.

;;; Code:

;; Define configuration variables
(defvar conf/serif-font
  (font-spec :family "Noto Serif"     :weight 'regular :size 11.0))
(defvar conf/sans-serif-font
  (font-spec :family "Noto Sans"      :weight 'regular :size 11.0))
(defvar conf/monospace-font
  (font-spec :family "Noto Sans Mono" :weight 'regular :size 11.0))

(defvar conf/user-backups-dir
  (expand-file-name "backups/"  user-emacs-directory))
(defvar conf/user-packages-dir
  (expand-file-name "packages/" user-emacs-directory))

;; Initially set garbage collection very high
(setq gc-cons-threshold (* 256 1024 1024))

;; Prefer newest file instead of first found
(setq load-prefer-newer t)

;; Remove annoying screens/popups/messages
(setq inhibit-startup-screen t)
(setq warning-minimum-level :error)
(setq native-comp-async-report-warnings-errors nil)

;; Set default frame parameters
(push '(tool-bar-lines . 0)     default-frame-alist)
(push '(menu-bar-lines . 0)     default-frame-alist)
(push '(vertical-scroll-bars)   default-frame-alist)

(push '(width  . 90)            default-frame-alist)
(push '(height . 40)            default-frame-alist)
(push '(alpha-background . 100) default-frame-alist)

;; Perform configuration setup
(mapc (lambda (dir)
        (when (not (file-directory-p dir))
          (make-directory dir)))
      (list conf/user-backups-dir
            conf/user-packages-dir))

(require 'package)
(require 'use-package)

(add-to-list 'load-path conf/user-packages-dir)

(add-to-list 'package-archives
             '("stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa"  . "https://melpa.org/packages/"))

(setq package-archive-priorities
      '(("gnu"    . 99)
        ("nongnu" . 80)
        ("stable" . 70)
        ("melpa"  . 10)))

;;; early-init.el ends here
