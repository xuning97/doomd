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
(package! rime)
(package! protobuf-mode)
(package! symbol-overlay)
(package! ggtags)
(package! annotate)
(package! org-modern)
(package! org-remark)
(package! emacsql-sqlite-builtin)
(package! imenu-list)

;; (unpin! org-roam)
(package! org-roam-ui)
(package! treesit-auto)
;; (unpin! dirvish)
;; (package! vertico-posframe)
;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
(package! citre
   :recipe (:host github :repo "universal-ctags/citre"))

;; (package! docker-tramp)
(package! valign
   :recipe (:host github :repo "casouri/valign"))

(package! clue
   :recipe (:host github :repo "AmaiKinono/clue"))
(package! blink-search
   :recipe (:host github :repo "manateelazycat/blink-search"))
(package! mind-wave
   :recipe (:host github :repo "manateelazycat/mind-wave" :files ("*.el" "*.py")))


(package! structurizr-mode
   :recipe (:host github :repo "gilesp/structurizr-mode"))
(package! ox-spectacle :recipe (:host github :repo "lorniu/ox-spectacle"))
(package! lsp-bridge
          :recipe (:host github :repo "manateelazycat/lsp-bridge"
                         :files ("*")))
(package! acm :recipe (:host github :repo "manateelazycat/lsp-bridge" :files ("acm")))
;; 如果没有上面这一行，安装 acm-terminal 的时候 doom sync 会报错，提示找不到 acm 这个包，不装 acm-terminal 不$
(package! popon)
(package! acm-terminal :recipe (:host github :repo "twlz0ne/acm-terminal"))
;; (package! lsp-bridge
;;    :recipe (:host github :repo "manateelazycat/lsp-bridge"
;;             :files ("*.el" "*.py" "acm/*.el" "acm/*.py" "acm/icons/*.svg" "langserver/*.json" "core/*.py" "core/handler/*.py")))

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
(package! rtags :disable t)
(package! irony :disable t)
(package! irony-eldoc :disable t)
(package! flycheck-irony :disable t)
(package! company-irony :disable t)
(package! company-irony-c-headers :disable t)

;;(package! docker-tramp :disable t) 
(package! go-guru :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))
