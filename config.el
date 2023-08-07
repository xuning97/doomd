;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Xu Ning"
      user-mail-address "xuning97@outlook.com")
(setq treesit-extra-load-path (list "~/.doom.d/tree-sitter"))
(setq byte-compile-warnings
      '(not
        ;; free-vars
        ;; unresolved
        ;; callargs
        ;; redefine
        ;; obsolete
        ;; noruntime
        ;; interactive-only
        ;; lexical
        ;; lexical-dynamic
        ;; make-local
        ;; mapcar
        ;; not-unused
        ;; constants
        docstrings
        ;; docstrings-non-ascii-quotes
        ;; suspicious
        ))
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(use-package org-journal
  :defer t
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%A, %d %B %Y"))

;; (after! go-mode
;;   (if (modulep! +lsp)
;;       (remove-hook 'go-mode-local-vars-hook #'lsp!)))

(remove-hook 'python-mode-local-vars-hook #'+python-init-anaconda-mode-maybe-h)

;; (use-package org-roam
;;   :custom
;;   (org-roam-database-connector 'sqlite-builtin))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; (use-package! lsp-bridge
;;   :hook
;;   (python-base-mode . lsp-bridge-mode)
;;   (c++-mode . lsp-bridge-mode)
;;   (c++-ts-mode . lsp-bridge-mode)
;;   (rustic-mode . lsp-bridge-mode)
;;   (go-mode . lsp-bridge-mode)
;;   (go-ts-mode . lsp-bridge-mode)
;;   :init
;;   (setq acm-enable-citre t)
;;   :config
;;   (set-lookup-handlers! 'rustic-mode :async t
;;                         :definition #'lsp-bridge-find-def
;;                         :implementations #'lsp-bridge-find-impl
;;                         :references #'lsp-bridge-find-references)
;;   (set-lookup-handlers! 'go-mode :async t
;;                         :definition #'lsp-bridge-find-def
;;                         :implementations #'lsp-bridge-find-impl
;;                         :references #'lsp-bridge-find-references)
;;   (evil-set-initial-state 'lsp-bridge-ref-mode 'insert))

;; ; (add-to-list 'lsp-bridge-lang-server-mode-list '(rustic-mode . "rust-analyzer"))

;; (unless (display-graphic-p)
;;   (after! acm
;;     (use-package! acm-terminal)))

(use-package! treesit-auto
  :config
  (global-treesit-auto-mode))

(use-package! mind-wave)


;; (after! god-mode
;;   (define-key god-local-mode-map (kbd ".") #'repeat)
;;   (define-key god-local-mode-map (kbd ".") #'repeat)
;;   (global-set-key (kbd "C-x C-1") #'delete-other-windows)
;;   (global-set-key (kbd "C-x C-2") #'split-window-below)
;;   (global-set-key (kbd "C-x C-3") #'split-window-right)
;;   (global-set-key (kbd "C-x C-0") #'delete-window))

;; (when (modulep! +lsp)
;;   (remove-hook! '(c-mode-local-vars-hook
;;                   c++-mode-local-vars-hook
;;                   objc-mode-local-vars-hook
;;                   cmake-mode-local-vars-hook)
;;     #'lsp!))


(use-package! citre
  :defer t
  :init
  ;; This is needed in `:init' block for lazy load to work.
  (require 'citre-config)
  ;; Bind your frequently used commands.
  (global-set-key (kbd "C-x c j") 'citre-jump)
  (global-set-key (kbd "C-x c J") 'citre-jump-back)
  (global-set-key (kbd "C-x c p") 'citre-ace-peek)
  (global-set-key (kbd "C-x c u") 'citre-update-this-tags-file)
  :config
  (setq
   ;; Set these if readtags/ctags is not in your path.
   ;; citre-readtags-program "/path/to/readtags"
   citre-ctags-program "/opt/homebrew/bin/ctags"
   ;; Set this if you use project management plugin like projectile.  It's
   ;; used for things like displaying paths relatively, see its docstring.
   citre-project-root-function #'projectile-project-root
   ;; Set this if you want to always use one location to create a tags file.
   citre-default-create-tags-file-location 'global-cache
   ;; See the "Create tags file" section above to know these options
   citre-use-project-root-when-creating-tags t
   citre-prompt-language-for-ctags-command t))

(use-package citre-global
  :ensure nil
  :defer t
  :init
  (global-set-key (kbd "C-x c r") 'citre-jump-to-reference)
  (global-set-key (kbd "C-x c P") 'citre-ace-peek-references)
  (global-set-key (kbd "C-x c U") 'citre-global-update-database)
  (with-eval-after-load 'citre-peek
    (define-key citre-peek-keymap (kbd "M-l r")
      'citre-peek-through-references)))

(use-package! valign
  :after org
  :config
  (add-hook 'org-mode-hook #'valign-mode))

(use-package! org-modern
  :after org
  :config
  (add-hook 'org-mode-hook #'org-modern-mode))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package rime
  :custom
  (default-input-method "rime")
  (rime--show-candidate 'posframe)
  (rime-disable-predicates
   '(rime-predicate-org-latex-mode-p
     rime-predicate-hydra-p
     rime-predicate-org-in-src-block-p
     rime-predicate-ace-window-p
     evil-normal-state-p)))

;;; Code:
(setq rime-user-data-dir "~/Library/Rime")

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

;; (use-package! vertico-posframe
;;  :after vertico
;;  :config
;;  (vertico-posframe-mode 1))

;; (use-package! sis
;;   :after (evil)
;;   :init
;;   (sis-ism-lazyman-config
;;    "com.apple.keylayout.ABC"
;;    "com.sogou.inputmethod.sogou.pinyin")
;;   :config
;;   (sis-global-respect-mode t)
;;   (sis-global-inline-mode t)
;;   (sis-global-context-mode t)
;;   (sis-global-cursor-color-mode t))

;; Not needed if your input sources are the same with the default values
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
