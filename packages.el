;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here, run 'doom sync' on
;; the command line, then restart Emacs for the changes to take effect.
;; Alternatively, use M-x doom/reload.


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)
;; (package! sis)
;; (package! rime)
;; (package! doom-themes)

(package! literate-calc-mode)
(package! protobuf-mode)
;; (package! annotate)
(package! org-modern)
(package! org-recur)
;; (package! org-remark)
;; (package! emacsql-sqlite-builtin)
;; (package! eglot-booster
;;    :recipe (:host github :repo "jdtsmith/eglot-booster"))
(package! imenu-list)
(package! breadcrumb)

;; (package! org-visual-outline
;;    :recipe (:host github :repo "legalnonsense/org-visual-outline"))
;; (package! org-journal :disable t)
(package! org-journal :recipe (:host github :repo "xuning97/org-journal"))

(package! eat
  :recipe (:host codeberg
           :repo "akib/emacs-eat"
           :files ("*.el" ("term" "term/*.el") "*.texi"
                   "*.ti" ("terminfo/e" "terminfo/e/*")
                   ("terminfo/65" "terminfo/65/*")
                   ("integration" "integration/*")
                   (:exclude ".dir-locals.el" "*-tests.el"))))
(package! denote)
(package! denote-menu)
(package! consult-denote)
(package! olivetti)

;; (unpin! org)
;; (package! org :pin "d6f3aed7b1b01df7b092a47099205847b34fdd37")
;; (unpin! org-roam)
(package! org-roam-ui)

(package! treesit-auto)
;; (package! tmux-pane)

;; (unpin! dirvish)
(package! vertico-posframe)
;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
(package! citre
   :recipe (:host github :repo "universal-ctags/citre"))

;; (package! docker-tramp)
;; (package! valign
;;    :recipe (:host github :repo "casouri/valign"))

(package! clue
   :recipe (:host github :repo "AmaiKinono/clue"))

(package! xonsh-mode)

(package! ztree)
(package! consult-notes)
(package! blink-search
  :recipe (:host github :repo "manateelazycat/blink-search"
           :files ("*.el" "*.py" "core" "backend" "icons")))

(package! mind-wave
   :recipe (:host github :repo "manateelazycat/mind-wave" :files ("*.el" "*.py")))

(package! svg-lib
          :recipe (:host github :repo "rougier/svg-lib"
                         :files ("*.el")))

(package! org-transclusion)
(package! ob-mermaid)
(package! openwith-mode
  :recipe (:host github :repo "thisirs/openwith" :files ("*.el")))

(package! org-yt
  :recipe (:host github :repo "TobiasZawada/org-yt" :files ("*.el")))

(package! xeft)
(package! org-timeclock
  :recipe (:host github :repo "ichernyshovvv/org-timeblock" :files ("*.el")))

(package! org-super-agenda)

(package! org-margin
          :recipe (:host github :repo "rougier/org-margin"
                         :files ("*.el")))
(package! exec-path-from-shell)
(package! color-rg
          :recipe (:host github :repo "manateelazycat/color-rg"
                         :files ("*.el")))

;; (package! structurizr-mode
;;    :recipe (:host github :repo "gilesp/structurizr-mode"))
;; (package! ox-spectacle :recipe (:host github :repo "lorniu/ox-spectacle"))

(when (package! lsp-bridge
        :recipe (:host github
                 :repo "manateelazycat/lsp-bridge"
                 :branch "master"
                 :files ("*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
                 ;; do not perform byte compilation or native compilation for lsp-bridge
                 :build (:not compile)))
  (package! markdown-mode)
  (package! yasnippet))

;; (package! evil-indent-plus)
;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))
