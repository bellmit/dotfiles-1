;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
(setq doom-font (font-spec :family "monospace" :size 34 :weight 'semi-light))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'tsdh-dark)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
(setq projectile-git-command t)

;; Don't let projectile auto track projects
(setq projectile-track-known-projects-automatically nil)

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer samrat/leader-key-def
    :keymaps '(normal visual emacs)
    :prefix "SPC"
    :global-prefix ";"))

;; Custom keybindings
(samrat/leader-key-def
  "t"  '(:ignore t :which-key "toggles")
  "w" 'save-buffer
  "m" 'doom/window-maximize-buffer
  "p" 'helm-show-kill-ring
  )

;; Replace default M-x with Helm's version
(map! :leader
      :desc "Use Helm's completion"
      ":"   #'helm-M-x)

;; Replace project find to search through git files
(map! :leader
      :desc "Search through git files"
      "p f"   #'counsel-git)

;; Leader + / to ripgrep through files
(map! :leader
      :desc "Use ripgrep for text in files"
      "/"   #'counsel-rg)

;; Remap swiper to swiper thing at point
(map! :leader
      :desc "Swiper search thing at point"
      "s b"   #'swiper-thing-at-point)

;; magit related
(samrat/leader-key-def
  "g"   '(:ignore t :which-key "git")
  "gs"  'magit-status
  "gl"   '(:ignore t :which-key "log")
  "glc" 'magit-log-current
  "gb"  'magit-branch
  "gP"  'magit-push-current
  "gf"  'magit-fetch
  "gr"  'magit-rebase)

;; Company mode
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
   ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; Projectile configuration
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (projectile-global-mode 1)
  :init
  (setq projectile-use-git-grep t
        ;; Fix for compilation command and `generic` projects
        projectile-project-compilation-cmd ""
        projectile-project-run-cmd ""
        projectile-project-search-path '("~/repo")
        projectile-switch-project-action #'projectile-dired)
)

;; Dired
(use-package dired
  :config
  (setq dired-dwim-target t)
  :hook (dired-mode . dired-hide-details-mode))

;; Helm configuration
(use-package helm
  :defer 2
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t
    helm-move-to-line-cycle-in-source t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 40)
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
)
