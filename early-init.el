;;; early-init.el --- Slightly opinionated default Emacs configuration

;;; Commentary:

;; This repository provides reasonable defaults of which to build a
;; personal Emacs configuration off.  It aims mainly to expose some of
;; the sticking points and non-obvious configurations that new users
;; might want to change.  While most of the configuration here will be
;; valuable to almost all users, they are slightly aligned with the
;; author's preferences.

;;; Code:

;; Initially set garbage collection very high
(setq-default gc-cons-threshold (* 256 1024 1024))

;; Prefer newest file instead of first found
(setq-default load-prefer-newer t)

;; Remove annoying screens/popups/messages
(setq-default inhibit-startup-screen t)
(setq-default warning-minimum-level :error)
(setq-default native-comp-async-report-warnings-errors nil)

;; Disable some GUI elements
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;;; early-init.el ends here
