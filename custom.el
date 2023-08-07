(put 'customize-group 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine 'XeLatex)
 '(TeX-engine-alist '((XeLatex "XeLatex" "xetex" "xelatex" "context")))
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))))
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "afa47084cb0beb684281f480aa84dab7c9170b084423c7f87ba755b15f6776ef" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "0466adb5554ea3055d0353d363832446cd8be7b799c39839f387abb631ea0995" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" "246a9596178bb806c5f41e5b571546bb6e0f4bd41a9da0df5dfbca7ec6e2250c" "333958c446e920f5c350c4b4016908c130c3b46d590af91e1e7e2a0611f1e8c5" "8146edab0de2007a99a2361041015331af706e7907de9d6a330a3493a541e5a6" "745d03d647c4b118f671c49214420639cb3af7152e81f132478ed1c649d4597d" "c2aeb1bd4aa80f1e4f95746bda040aafb78b1808de07d340007ba898efa484f5" default))
 '(dap-python-debugger 'debugpy)
 '(dtrt-indent-min-offset 4)
 '(evil-shift-width 2)
 '(flycheck-clang-language-standard "c++20")
 '(flycheck-gcc-language-standard "c++20")
 '(grep-command "ggrep")
 '(ispell-grep-command "ggrep")
 '(lsp-bridge-python-command "python3.11")
 '(mind-wave-api-key-path "~/.emacs.d/.local/mind-wave/chatgpt_api_key.txt")
 '(org-M-RET-may-split-line t)
 '(org-agenda-files
   '("/Users/ning/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal/20220425.org"))
 '(org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
 '(org-journal-file-format "%Y%m%d.org")
 '(org-journal-file-type 'weekly)
 '(org-latex-compiler "xelatex")
 '(org-latex-hyperref-template
   "\\hypersetup{\12 pdfauthor={%a},\12 pdftitle={%t},\12 pdfkeywords={%k},\12 pdfsubject={%d},\12 pdfcreator={%c}, \12 pdflang={%L},\12 colorlinks=true}")
 '(org-roam-database-connector 'sqlite-builtin)
 '(plantuml-default-exec-mode 'jar)
 '(plantuml-jar-args '("-charset" "UTF-8" "-DRELATIVE_INCLUDE=."))
 '(python-interpreter "python3.11")
 '(python-shell-interpreter "python3.11")
 '(pyvenv-virtualenvwrapper-python "/opt/homebrew/bin/python3.11")
 '(realgud:pdb-command-name "python3 -m pdb")
 '(rime-emacs-module-header-root "/opt/homebrew/Cellar/emacs-plus@30/30.0.50/include")
 '(rime-librime-root "/Users/ning/.doom.d/librime/dist")
 '(safe-local-variable-values
   '((org-roam-db-location . "~/org/roam/coderead/tidb/org-roam.db")
     (org-roam-db-location . "~/org/roam/tidb/coderead/tidb/org-roam.db")
     (org-roam-db-location . "~/org/roam/tidb/coderead/org-roam.db")
     (org-roam-directory . "~/org/roam/coderead/tidb")
     (org-roam-db-location . "~/org/roam/mysql/org-roam.db")
     (org-roam-directory . "~/org/roam/mysql")
     (org-roam-db-location . "~/org/roam/tidb/org-roam.db")
     (org-roam-directory . "~/org/roam/tidb")))
 '(standard-indent 2)
 '(straight-vc-git-default-protocol 'ssh))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-remark-highlighter ((t (:background "dark cyan" :underline (:color "dark cyan" :style wave :position nil)))))
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(put 'customize-variable 'disabled nil)
(put 'customize-face 'disabled nil)
