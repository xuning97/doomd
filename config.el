;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Xu Ning"
      user-mail-address "xuning97@outlook.com")
;; (setq treesit-extra-load-path (list "~/.doom.d/tree-sitter"))
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
(xterm-mouse-mode 1)

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
;; (setq doom-font (font-spec :family "FantasqueSansMono Nerd Font" :size 18)
;;       doom-big-font (font-spec :family "FantasqueSansMono Nerd Font" :size 24)
;;       doom-theme 'doom-fairy-floss)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(use-package! org
  :config
  (setq org-directory "~/org/"))

(use-package! org-journal
  :after org
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%A, %d %B %Y")
  (defun org-journal-find-location ()
    ;; Open today's journal, but specify a non-nil prefix argument in order to
    ;; inhibit inserting the heading; org-capture will insert the heading.
    (org-journal-new-entry t)
    (unless (eq org-journal-file-type 'daily)
      (org-narrow-to-subtree))
    (goto-char (point-max)))
  (add-to-list 'org-capture-templates '("a" "Journal todo entry" plain (function org-journal-find-location)
                                        "** TODO %(format-time-string org-journal-time-format)%^{Title}\n%U\n%i"
                                        :jump-to-captured t :immediate-finish t))
  (add-to-list 'org-capture-templates '("i" "Journal note entry" plain (function org-journal-find-location)
                                        "** %(format-time-string org-journal-time-format)%^{Title}\n%U\n%i"
                                        :jump-to-captured t :immediate-finish t)))
;; (after! go-mode
;;   (if (modulep! +lsp)
;;       (remove-hook 'go-mode-local-vars-hook #'lsp!)))

;; (remove-hook 'python-mode-local-vars-hook #'+python-init-anaconda-mode-maybe-h)

;; (use-package org-roam
;;   :custom
;;   (org-roam-database-connector 'sqlite-builtin))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(use-package! lsp-mode
  ;; :hook ((prog-mode . lsp-deferred))
  :init (setq lsp-log-io t)
  :commands (lsp lsp-deferred)
  :config
  (progn
    (with-eval-after-load 'lsp-clangd
      (lsp-register-client
       (make-lsp-client :new-connection (lsp-tramp-connection
                                         "clangd")
                        ;; "/home/ning.xu/.config/emacs/.local/etc/lsp/clangd/clangd_15.0.6/bin/clangd")
                        :major-modes '(c-mode c++-mode c++-ts-mode)
                        :remote? t
                        :server-id 'clangd-tramp)))))

(defun xn/produce-pomodoro-string-for-menu-bar ()
  "Produce the string for the current pomodoro counter to display on the menu bar"
  (if (featurep 'org-pomodoro)
      (let ((prefix (cl-case org-pomodoro-state
                      (:pomodoro "P")
                      (:overtime "O")
                      (:short-break "B")
                      (:long-break "LB"))))
        (if (and (org-pomodoro-active-p) (> (length prefix) 0))
            (list prefix (org-pomodoro-format-seconds)) "N/A"))
      "N/A"))

;; (use-package eglot-booster
;; 	:after eglot
;; 	:config (eglot-booster-mode))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

;;( use-package! lsp-bridge
;;  :config
;;  (setq lsp-bridge-enable-log nil)
;;  (setq lsp-bridge-python-command "~/.pyenv/versions/3.9.12/bin/python3"))
;;  (global-lsp-bridge-mode))

;; (use-package! lsp-bridge
;;   :hook
;;   (python-base-mode . lsp-bridge-mode)
;;   (c++-mode . lsp-bridge-mode)
;;   (c++-ts-mode . lsp-bridge-mode)
;;   (rustic-mode . lsp-bridge-mode)
;;   (go-mode . lsp-bridge-mode)
;;   (go-ts-mode . lsp-bridge-mode)
;;   :init
;;   (setq lsp-bridge-enable-with-tramp t)
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

;; (add-to-list 'lsp-bridge-lang-server-mode-list '(rustic-mode . "rust-analyzer"))

;; (unless (display-graphic-p)
;;   (after! acm
;;     (use-package! acm-terminal)))


(use-package! evil-collection
  :ensure t
  :config
  (advice-add 'evil-collection-minibuffer-insert
              :after #'(lambda () (progn
                                    (evil-normal-state)
                                    (evil-emacs-state 1)
                                    (doom/forward-to-last-non-comment-or-eol)))))

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


(use-package! org-modern
  :after org
  :config
  (global-org-modern-mode 1))
;; (use-package! valign
;;   :after org
;;   :config
;;   (add-hook 'org-mode-hook #'valign-mode))

;; (use-package! valign
;;   :after org
;;   :hook
;;   (org-mode . valign-mode)
;;   :config
;;   (setq valign-fancy-bar t))

;; (use-package! tmux-pane
;;  :config
;;  (tmux-pane-mode)
;;  (map! :leader
;;        (:prefix ("v" . "tmux pane")
;;          :desc "Open vpane" :nv "o" #'tmux-pane-open-vertical
;;          :desc "Open hpane" :nv "h" #'tmux-pane-open-horizontal
;;          :desc "Open hpane" :nv "s" #'tmux-pane-open-horizontal
;;          :desc "Open vpane" :nv "v" #'tmux-pane-open-vertical
;;          :desc "Close pane" :nv "c" #'tmux-pane-close
;;          :desc "Rerun last command" :nv "r" #'tmux-pane-rerun))
;;  (map! :leader
;;        (:prefix "t"
;;          :desc "vpane" :nv "v" #'tmux-pane-toggle-vertical
;;          :desc "hpane" :nv "h" #'tmux-pane-toggle-horizontal)))

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
(use-package! org-pomodoro
  :ensure nil
  :defer t
  :config
  (progn
    ;; org-pomodoro mode hooks
    (add-hook 'org-pomodoro-finished-hook
              (lambda ()
                (alert "Time for a break." :title "Pomodoro completed!")))

    (add-hook 'org-pomodoro-break-finished-hook
              (lambda ()
                (alert "Pomodoro Short Break Finished" :title "Ready for Another?")))

    (add-hook 'org-pomodoro-long-break-finished-hook
              (lambda ()
                (alert "Pomodoro Long Break Finished" :title "Ready for Another?")))

    (add-hook 'org-pomodoro-killed-hook
              (lambda ()
                (alert "One does not simply kill a pomodoro!" :title "Pomodoro Killed")))))

;; (use-package rime
;;  :custom
;;  (default-input-method "rime")
;;  (rime--show-candidate 'posframe)
;;  (rime-disable-predicates
;;   '(rime-predicate-org-latex-mode-p
;;     rime-predicate-hydra-p
;;     rime-predicate-org-in-src-block-p
;;     rime-predicate-ace-window-p
;;     evil-normal-state-p)))

;;; Code:
;; (setq rime-user-data-dir "~/Library/Rime")

;; (setq rime-posframe-properties
;;      (list :background-color "#333333"
;;             :foreground-color "#dcdccc"
;;             :font "WenQuanYi Micro Hei Mono-14"
;;             :internal-border-width 10))

;; (setq default-input-method "rime"
;;       rime-show-candidate 'posframe)

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

(with-eval-after-load 'org
  (use-package org-super-agenda
    :after org
    :ensure t
    :config
    (setq org-agenda-custom-commands
          '(("rd" "MyView"
             ((agenda "" ((org-agenda-span 2)
                          (org-super-agenda-groups
                           '((:name "Today"
                              :time-grid t
                              :date today
                              :todo "TODAY"
                              :scheduled today
                              :order 1)
                             (:discard (:anything t))
                             ))))
              (alltodo "" ((org-agenda-overriding-header "")
                           (org-agenda-sorting-strategy '(deadline-up))
                           (org-super-agenda-groups
                            '((:name "Important"
                               :property "urgent"
                               :order 1)
                              (:name "Expired"
                               :deadline past
                               :order 2)
                              (:name "Due today"
                               :deadline today
                               :order 3)
                              (:name "Current Taks"
                               :todo ("INPROGRESS" "ONGOING")
                               :order 4)
                              (:name "Next ToDos"
                               :todo ("NEXT" "STRT")
                               :order 5)
                              (:name "Drafts"
                               :todo ("IDEA" "DRAFT")
                               :order 6)

                              ))))))
            ("inf" "InfAgenda" tags "filename={INFIT}"(
                                                       (org-agenda-skip-function
                                                        '(org-agenda-skip-entry-if 'notregexp "\\* INPROGRESS\\|\\* STRT\\|* WAITING\\|* DRAFT\\|* TODO\\|* BACKLOG\\|* NEXT\\|* ONGOING\\|* PROJ\\|* TODAY"))
                                                       (org-agenda-sorting-strategy '(deadline-up))
                                                       (org-agenda-view-columns-initially t)))
            ("w" todo "WAITING")
            ("iq" todo "NEXT")
            ("ip" todo "INPROGRESS")
            ("d" todo "DRAFT")
            ("y" agenda*)
            ))))


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
