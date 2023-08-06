(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(set-frame-parameter (selected-frame) 'alpha '(95))
(add-to-list 'default-frame-alist '(alpha . (95)))
;;(add-to-list 'default-frame-alist '(undecorated . t))
;;(add-to-list 'initial-frame-alist '(undecorated . t))

(put 'suspend-frame 'disabled t)
(setq ring-bell-function 'ignore)
(setq use-dialog-box nil)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))

(add-to-list 'load-path "~/.notemacx/nano-emacs")
(add-to-list 'load-path ".")
(package-initialize)

(unless (package-installed-p 'use-package) 
  (package-refresh-contents) 
  (package-install 'use-package))

(unless (package-installed-p 'quelpa) 
  (package-refresh-contents) 
  (package-install 'quelpa))

(unless (package-installed-p 'quelpa-use-package) 
  (package-refresh-contents) 
  (package-install 'quelpa-use-package))

(require 'use-package)
(require 'quelpa)
(require 'quelpa-use-package)

;; ============================================= PACKAGES CONFIG =====================================
(use-package 
  elisp-format 
  :ensure t 
  :init (global-unset-key (kbd "C-M-l")) 
  :config (define-key emacs-lisp-mode-map (kbd "C-M-l") 'elisp-format-buffer) 
  (setq elisp-format-column 80))

(use-package 
  centuri 
  :ensure t 
  :quelpa (centuri :fetcher github 
                   :repo "henryco/centuri-el") 
  :config (setq centuri--buffers-ignored '(" *MINIMAP*")))

(use-package 
  pos-tip 
  :ensure t)

(use-package 
  magit 
  :ensure t)

(use-package 
  diff-hl 
  :ensure t 
  :config (global-diff-hl-mode) 
  (diff-hl-flydiff-mode) 
  :hook (magit-pre-refresh-hook . diff-hl-magit-pre-refresh) 
  (magit-post-refresh-hook . diff-hl-magit-post-refresh) 
  (prog-mode . diff-hl-margin-mode) 
  (text-mode . diff-hl-margin-mode))

(use-package 
  company 
  :ensure t 
  :after pos-tip 
  :config (defun custom-prog-company-mode () 
            (global-set-key (kbd "C-SPC") 'company-complete) 
            (company-mode)) 
  :hook (prog-mode . custom-prog-company-mode))

(use-package 
  company-quickhelp 
  :ensure t 
  :after company 
  :config (defun custom-prog-quick-company-mode () 
            (company-quickhelp-mode)) 
  :hook (prog-mode . custom-prog-quick-company-mode))

(use-package 
  anzu 
  :ensure t 
  :config (global-anzu-mode 1))

(use-package 
  expand-region 
  :ensure t 
  :bind ("C-c e" . er/expand-region))

(use-package 
  shell-pop 
  :ensure t 
  :init (setq shell-pop-term-shell "/bin/bash") 
  (setq shell-pop-universal-key "C-c t") 
  (setq shell-pop-full-span t) 
  (setq shell-pop-window-position "bottom") 
  (setq shell-pop-autocd-to-working-dir t))

(use-package 
  dimmer 
  :ensure t 
  :demand t 
  :config (setq dimmer-use-colorspace 
                :rgb) 
  (setq dimmer-fraction 0.2) 
  (dimmer-configure-company-box) 
  (dimmer-configure-which-key) 
  (dimmer-configure-posframe) 
  (dimmer-configure-magit)
  ;; (dimmer-mode t)
  )

(use-package 
  vertico 
  :ensure t 
  :init (vertico-mode) 
  (vertico-mouse-mode) 
  (vertico-indexed-mode) 
  :config (setq vertico-posframe-width 110) 
  (defun my-vertico-select (index) 
    (interactive) 
    (vertico-next (if (string= vertico-preselect 'prompt) 
                      (+ index 1) index))
    ;; If `vertico-preselect' is `first' or `prompt', it's mostly working but when `directory'
    ;; the default value, is described as "Like first, but select the prompt if it is a directory",
    ;; so the condition switch (the first list item is directory or not) is needed.
    (vertico-exit)) 
  (define-key minibuffer-local-map (kbd "C-0") 
    (lambda () 
      (interactive) 
      (my-vertico-select 0))) 
  (define-key minibuffer-local-map (kbd "C-1") 
    (lambda () 
      (interactive) 
      (my-vertico-select 1))) 
  (define-key minibuffer-local-map (kbd "C-2") 
    (lambda () 
      (interactive) 
      (my-vertico-select 2))) 
  (define-key minibuffer-local-map (kbd "C-3") 
    (lambda () 
      (interactive) 
      (my-vertico-select 3))) 
  (define-key minibuffer-local-map (kbd "C-4") 
    (lambda () 
      (interactive) 
      (my-vertico-select 4))) 
  (define-key minibuffer-local-map (kbd "C-5") 
    (lambda () 
      (interactive) 
      (my-vertico-select 5))) 
  (define-key minibuffer-local-map (kbd "C-6") 
    (lambda () 
      (interactive) 
      (my-vertico-select 6))) 
  (define-key minibuffer-local-map (kbd "C-7") 
    (lambda () 
      (interactive) 
      (my-vertico-select 7))) 
  (define-key minibuffer-local-map (kbd "C-8") 
    (lambda () 
      (interactive) 
      (my-vertico-select 8))) 
  (define-key minibuffer-local-map (kbd "C-9") 
    (lambda () 
      (interactive) 
      (my-vertico-select 9))))

(use-package 
  vertico-posframe 
  :ensure t 
  :after vertico 
  :config (when (display-graphic-p) 
            (vertico-posframe-mode)))

(use-package 
  marginalia 
  :ensure t 
  :init (marginalia-mode))

(use-package 
  orderless 
  :ensure t 
  :custom (completion-styles '(orderless basic)) 
  (completion-category-overrides '((file (styles basic partial-completion)))) 
  (orderless-matching-styles '(orderless-literal orderless-prefixes
                                                 orderless-initialism
                                                 orderless-regexp orderless-flex
                                        ; Basically fuzzy finding
                                                 )))

(use-package 
  savehist 
  :ensure t 
  :init (savehist-mode))

(use-package 
  nerd-icons 
  :demand t 
  :ensure t 
  :custom (nerd-icons-font-family "RobotoMono Nerd Font") 
  :config (set-face-attribute 'default nil 
                              :font "RobotoMono Nerd Font"))

(use-package 
  nerd-icons-dired 
  :ensure t 
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package 
  nerd-icons-completion 
  :ensure t 
  :after marginalia 
  :config (nerd-icons-completion-mode) 
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package 
  nerd-icons-ibuffer 
  :ensure t 
  :config (setq nerd-icons-ibuffer-icon t) 
  (setq nerd-icons-ibuffer-color-icon t) 
  (setq nerd-icons-ibuffer-color-icon t) 
  (setq nerd-icons-ibuffer-icon-size 1.0) 
  (setq  nerd-icons-ibuffer-human-readable-size t) 
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package 
  pulsar 
  :ensure t 
  :config (defun scroll-half-page-down () 
            "scroll down half the page" 
            (interactive) 
            (scroll-down (/ (window-body-height) 10)) 
            (pulsar-pulse-line-red)) 
  (defun scroll-half-page-up () 
    "scroll up half the page" 
    (interactive) 
    (scroll-up (/ (window-body-height) 10)) 
    (pulsar-pulse-line-red)) 
  (defun scroll-full-page-down () 
    "scroll full the page down" 
    (interactive) 
    (scroll-down) 
    (pulsar-pulse-line-red)) 
  (defun scroll-full-page-up () 
    "scroll full the page down up" 
    (interactive) 
    (scroll-up) 
    (pulsar-pulse-line-red)) 
  (global-set-key (kbd "<prior>") 'scroll-half-page-down) 
  (global-set-key (kbd "<next>") 'scroll-half-page-up) 
  (global-set-key (kbd "s-<prior>") 'scroll-full-page-down) 
  (global-set-key (kbd "s-<next>") 'scroll-full-page-up) 
  (add-hook 'next-error-hook #'pulsar-pulse-line-red) 
  (setq pulsar-pulse t) 
  (pulsar-global-mode 1))

(use-package 
  ace-jump-mode 
  :ensure t 
  :config (autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode"
            t) 
  (setq ace-jump-mode-scope 'global) 
  (define-key global-map (kbd "C-`") 'ace-jump-char-mode) 
  (define-key global-map (kbd "C-<f1>") 'ace-jump-line-mode) 
  (define-key global-map (kbd "C-<escape>") 'ace-jump-mode))

(use-package 
  ace-window 
  :after (pulsar) 
  :ensure t 
  :config (defun custom-ace-window-fun (arg) 
            (interactive "p") 
            (ace-window arg) 
            (pulsar-pulse-line-red)) 
  (global-set-key (kbd "M-o") 'custom-ace-window-fun))

(use-package 
  treemacs 
  :after (pulsar) 
  :ensure t 
  :init (setq treemacs-position 'right) 
  :config (treemacs-follow-mode t) 
  (treemacs-filewatch-mode t) 
  (treemacs-fringe-indicator-mode 'always) 
  (defun custom-treemacs-window-switch 
      (&optional 
       arg) 
    (interactive "P") 
    (treemacs-select-window arg) 
    (pulsar-pulse-line-red)) 
  :bind (:map global-map
              ("M-0"       . custom-treemacs-window-switch) 
              ("C-x t t"   . treemacs) 
              ("C-x t d"   . treemacs-select-directory) 
              ("C-x t b"   . treemacs-bookmark) 
              ("C-x t f"   . treemacs-find-file) 
              ("C-x t M-t" . treemacs-find-tag)))

(use-package 
  treemacs-nerd-icons 
  :after (treemacs nerd-icons) 
  :ensure t 
  :config (treemacs-load-theme "nerd-icons"))

(use-package 
  projectile 
  :ensure t
  ;; TODO
  )

(use-package 
  treemacs-projectile 
  :after (treemacs projectile) 
  :ensure t)

(use-package 
  treemacs-magit 
  :after (treemacs magit) 
  :ensure t)

(use-package 
  dashboard 
  :ensure t 
  :after nerd-icons 
  :init (setq dashboard-banner-logo-title
              "Lasciate ogne speranza, voi ch'intrate") 
  (setq dashboard-startup-banner "~/.notemacx/lisp_logo.png") 
  (setq dashboard-display-icons-p t) 
  (setq dashboard-icon-type 'nerd-icons) 
  (setq dashboard-set-heading-icons t) 
  (setq dashboard-set-file-icons t) 
  (setq dashboard-set-navigator t) 
  (setq dashboard-set-init-info t) 
  (setq dashboard-center-content t) 
  (setq dashboard-show-shortcuts t) 
  (setq dashboard-set-footer nil) 
  (setq dashboard-items '((recents  . 5) 
                          ;; (projects . 5) 
                          (bookmarks . 5)
                          ;; (agenda . 5)
                          ;; (registers . 5)
			              )) 
  :config (dashboard-setup-startup-hook))

(use-package 
  smartparens 
  :ensure t 
  :hook (prog-mode . smartparens-mode))

(use-package 
  which-key 
  :ensure t 
  :config (setq which-key-popup-type 'minibuffer) 
  (setq which-key-idle-secondary-delay nil) 
  (setq which-key-idle-delay 1) 
  (which-key-mode))

(use-package 
  zzz-to-char 
  :ensure t 
  :config (setq zzz-to-char-reach 200) 
  (global-set-key (kbd "M-z") 'zzz-to-char-up-to-char))

(use-package 
  focus 
  :ensure t 
  :config (global-unset-key (kbd "C-x C-z")) 
  (global-set-key (kbd "C-c C-z") 'focus-mode))

(use-package 
  goto-line-preview 
  :ensure t 
  :config (global-set-key (kbd "M-g M-g") 'goto-line-preview))

(use-package 
  windresize 
  :ensure t 
  :config (global-set-key (kbd "C-=") 'windresize))

(use-package 
  auto-highlight-symbol 
  :ensure t 
  :hook (prog-mode . auto-highlight-symbol-mode))

(use-package 
  mwim 
  :ensure t 
  :config (global-set-key (kbd "C-a") 'mwim-beginning) 
  (global-set-key (kbd "C-e") 'mwim-end))

(use-package 
  rainbow-delimiters 
  :ensure t 
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package 
  yascroll 
  :ensure t 
  :hook (text-mode . yascroll-bar-mode) 
  (prog-mode . yascroll-bar-mode) 
  (custom-mode . yascroll-bar-mode) 
  (dired-mode . yascroll-bar-mode) 
  (dashboard-mode . yascroll-bar-mode) 
  (term-mode . yascroll-bar-mode) 
  (calendar-mode . yascroll-bar-mode) 
  (org-agenda-mode . yascroll-bar-mode))

(use-package 
  minimap 
  :ensure t 
  :if (display-graphic-p) 
  :config (minimap-mode))

(use-package 
  drag-stuff 
  :ensure t 
  :config (drag-stuff-global-mode t) 
  (drag-stuff-define-keys))

(use-package 
  popwin 
  :ensure t 
  :config (popwin-mode 1) 
  (push '(vundo-mode :height 0.5 
                     :position bottom) popwin:special-display-config))

(use-package 
  shackle 
  :config (setq shackle-rules '((compilation-mode :noselect t)
                                        ;("*vundo tree*" :select t :popup t :align below :ratio 0.33)
                                )) 
  (shackle-mode 1))

(use-package 
  vundo 
  :ensure t 
  :config (global-unset-key (kbd "C-z")) 
  (global-set-key (kbd "C-z") 'vundo) 
  (setq vundo-compact-display nil) 
  (setq vundo-glyph-alist vundo-unicode-symbols) 
  (set-face-attribute 'vundo-default nil 
                      :family "monospace"))

(use-package 
  goggles 
  :ensure t 
  :hook ((prog-mode text-mode) . goggles-mode) 
  :config (setq-default goggles-pulse t))

(use-package 
  centaur-tabs 
  :ensure t 
  :demand t 
  :config (set-face-attribute 'centaur-tabs-default nil 
                              :foreground "3d3c3d" 
                              :background "white") 
  (setq centaur-tabs-height 31 centaur-tabs-icon-type 'nerd-icons
        centaur-tabs-gray-out-icons 'buffer centaur-tabs-icon-scale-factor 0.95
        centaur-tabs-style "bar" centaur-tabs-background-color (face-background
                                                                'centaur-tabs-default)
        centaur-tabs-set-bar nil centaur-tabs-set-modified-marker nil
        centaur-tabs-show-new-tab-button nil
        centaur-tabs-show-navigation-buttons nil centaur-tabs-show-count nil
        centaur-tabs-plain-icons t centaur-tabs-set-icons t
        centaur-tabs-set-close-button nil) 
  (setq uniquify-separator "/")
  ;; (centaur-tabs-headline-match)
  (centaur-tabs-mode t) 
  (defun centaur-tabs-hide-tab (x) 
    "Do no to show buffer X in tabs."
    (let ((name (format "%s" x))) 
      (or
       ;; Current window is not dedicated window.
       (window-dedicated-p (selected-window))

       ;; Buffer name not match below blacklist.
       (string-prefix-p "*epc" name) 
       (string-prefix-p "*helm" name) 
       (string-prefix-p "*Helm" name) 
       (string-prefix-p "*Compile-Log*" name) 
       (string-prefix-p "*lsp" name) 
       (string-prefix-p "*company" name) 
       (string-prefix-p "*Flycheck" name) 
       (string-prefix-p "*tramp" name) 
       (string-prefix-p " *Mini" name) 
       (string-prefix-p "*help" name) 
       (string-prefix-p "*straight" name) 
       (string-prefix-p " *temp" name) 
       (string-prefix-p "*Help" name) 
       (string-prefix-p "*mybuf" name) 
       (string-prefix-p "*Register Preview*" name) 
       (string-prefix-p "*Disabled Command*" name) 
       (string-prefix-p "*completions" name) 
       (string-prefix-p "*Ibuffer confirmation" name) 
       (string-prefix-p "*Colors*" name) 
       (string-prefix-p " *minimap*" name) 
       (string-prefix-p "*dashboard" name)

       ;; is not magit buffer.
       (and (string-prefix-p "magit" name) 
            (not (file-name-extension name)))))) 
  (defun centaur-tabs-buffer-groups () 
    "`centaur-tabs-buffer-groups' control buffers' group rules.
      Group centaur-tabs with mode if buffer is derived from
     `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
      All buffer name start with * will group to \"Emacs\".
      Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list (cond ((string-prefix-p "*shell" (buffer-name)) "Shell") 
                ((string-prefix-p "*dashboard" (buffer-name)) "Dashboard") 
                ((memq major-mode '(magit-process-mode magit-status-mode
                                                       magit-diff-mode
                                                       magit-log-mode
                                                       magit-file-mode
                                                       magit-blob-mode
                                                       magit-blame-mode))
                 "Magit") 
                ((derived-mode-p 'prog-mode) "Editing") 
                ((derived-mode-p 'dired-mode) "Dired") 
                ((memq major-mode '(helpful-mode help-mode)) "Help") 
                ((memq major-mode '(org-mode org-agenda-clockreport-mode
                                             org-src-mode org-agenda-mode
                                             org-beamer-mode org-indent-mode
                                             org-bullets-mode org-cdlatex-mode
                                             org-agenda-log-mode diary-mode))
                 "OrgMode") 
                ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs") 
                (t (centaur-tabs-get-group-name (current-buffer)))))) 
  :bind ("C-<next>" . centaur-tabs-backward) 
  ("C-<prior>" . centaur-tabs-forward) 
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-left) 
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-right) 
  :hook (dired-mode . centaur-tabs-local-mode) 
  (dashboard-mode . centaur-tabs-local-mode) 
  (term-mode . centaur-tabs-local-mode) 
  (calendar-mode . centaur-tabs-local-mode) 
  (org-agenda-mode . centaur-tabs-local-mode))


;; ================================================ nano theme config =====================================
(setq nano-font-family-monospaced "RobotoMono Nerd Font")
(setq nano-color-salient "slate gray")
(setq nano-font-size 13)

;; theming command line options (this will cancel warning messages)
(add-to-list 'command-switch-alist '("-light"  . (lambda (args))))
(add-to-list 'command-switch-alist '("-default"  . (lambda (args))))

;; customize support for 'emacs -q' (optional)
;; you can enable customizations by creating the nano-custom.el file
;; with e.g. `touch nano-custom.el` in the folder containing this file.
(let* ((this-file  (or load-file-name 
                       (buffer-file-name))) 
       (this-dir  (file-name-directory this-file)) 
       (custom-path  (concat this-dir "nano-custom.el"))) 
  (when (and (eq nil user-init-file) 
             (eq nil custom-file) 
             (file-exists-p custom-path)) 
    (setq user-init-file this-file) 
    (setq custom-file custom-path) 
    (load custom-file)))

;; theme
(require 'nano-faces)
(require 'nano-theme)
(require 'nano-theme-light)

(cond ((member "-default" command-line-args) t) 
      (t (nano-theme-set-light)))

(call-interactively 'nano-refresh-theme)

;; nano default settings (optional)
(require 'nano-defaults)

;; nano session saving (optional)
(require 'nano-session)

;; nano header & mode lines (optional)
;; (require 'nano-modeline)

(require 'nano-help)

(provide 'nano)
(menu-bar-mode -1)

(set-face-attribute 'nano-face-salient nil 
                    :foreground "slate gray" 
                    :weight 'semi-light)

(set-face-attribute 'nano-face-faded nil 
                    :foreground "slate gray" 
                    :weight 'light)


;; ================================================ custom config ================================================
(defun duplicate-line-or-region 
    (&optional 
     n)
  "duplicate current line, or region if active.
   with argument n, make n copies.
   with negative n, comment out original line and use the absolute value." 
  (interactive "*p") 
  (let ((use-region (use-region-p))) 
    (save-excursion (let ((text (if use-region ;get region if active, otherwise line
                                    (buffer-substring 
                                     (region-beginning) 
                                     (region-end)) 
                                  (prog1 (thing-at-point 'line) 
                                    (end-of-line) 
                                    (if (< 0 (forward-line 1)) ;go to beginning of next line, or make a new one
                                        (newline)))))) 
                      (dotimes (i (abs (or n 
                                           1))) ;insert n times, or once if not specified
                        (insert text)))) 
    (if use-region nil ;only if we're working with a line (not a region)
      (let ((pos (- (point) 
                    (line-beginning-position)))) ;save column
        (if (> 0 n)            ;comment out original with negative arg
            (comment-region (line-beginning-position) 
                            (line-end-position))) 
        (forward-line 1) 
        (forward-char pos)))))

(defun custom-prettify-mode-hook () 
  (setq prettify-symbols-alist '(("lambda"  . ?λ) 
                                 ("!=" . ?≠) 
                                 ("->" . ?→) 
                                 ("=>" . ?⇒) 
                                 (">=" . ?≥) 
                                 ("<=" . ?≤) 
                                 ("=<<" . (?= (br . bl) ?≪)) 
                                 (">>=" . (?≫ (br . bl) ?=)))) 
  (prettify-symbols-mode))

(defface custom-prog-mode-font-face 
  '((t :inherit default 
       :height 115 
       :foreground "gray4")) 
  "custom face for larger font size in programming buffers.")

(defun custom-prog-mode-hook () 
  (buffer-face-set 'custom-prog-mode-font-face))

(add-hook 'prog-mode-hook (lambda () 
                            (set-face-attribute 'default nil 
                                                :weight 'light)))

(add-hook 'prog-mode-hook 'custom-prog-mode-hook)
(add-hook 'prog-mode-hook 'custom-prettify-mode-hook)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

(set-face-attribute 'region nil 
                    :foreground "white" 
                    :background "red3" 
                    :weight 'normal)

(set-face-attribute 'minibuffer-prompt nil 
                    :foreground "red2")

(global-unset-key (kbd "C-SPC"))
(global-unset-key (kbd "C-x C-SPC"))

(global-set-key (kbd "C-x C-SPC") 'rectangle-mark-mode)
(global-set-key (kbd "C-c SPC") 'set-mark-command)
(global-set-key (kbd "C-c C-SPC") 'set-mark-command)
(global-set-key (kbd "C-d") 'duplicate-line-or-region)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; ========================================================= generated ======================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-highlight-all-windows nil) 
 '(ahs-idle-interval 0.001) 
 '(aw-char-position 'top-right) 
 '(aw-ignored-buffers '("*calc trail*" " *lv*" " *minimap*")) 
 '(beacon-dont-blink-major-modes '(t magit-status-mode magit-popup-mode
                                     inf-ruby-mode mu4e-headers-mode
                                     gnus-summary-mode gnus-group-mode
                                     minimap-mode)) 
 '(custom-safe-themes '("1781e8bccbd8869472c09b744899ff4174d23e4f7517b8a6c721100288311fa5"
                        default)) 
 '(dashboard-heading-icon-height 1.0) 
 '(dashboard-path-max-length 40) 
 '(dashboard-path-style 'truncate-beginning) 
 '(diff-hl-draw-borders nil) 
 '(diff-hl-margin-symbols-alist '((insert . "|") 
                                  (delete . "|") 
                                  (change . "|") 
                                  (unknown . "?") 
                                  (ignored . "|"))) 
 '(highlight-symbol-idle-delay 0) 
 '(minimap-always-recenter nil) 
 '(minimap-disable-mode-line t) 
 '(minimap-hide-cursor t) 
 '(minimap-hide-fringes t) 
 '(minimap-highlight-line t) 
 '(minimap-major-modes '(prog-mode text-mode)) 
 '(minimap-minimum-width 35) 
 '(minimap-recenter-type 'relative) 
 '(minimap-update-delay 0.025) 
 '(mode-line-in-non-selected-windows nil) 
 '(nano-color-faded "seashell4") 
 '(nano-color-subtle "light slate gray") 
 '(package-selected-packages '(elisp-format diff-hl company-quickhelp company
                                            company-elisp pos-tip anzu
                                            popup-kill-ring browse-kill-ring
                                            expand-region shell-pop dimmer
                                            vertico-posframe vertico
                                            treemacs-icons-dired treemacs-magit
                                            treemacs-projectile nano-modeline
                                            projectile nerd-icons-dired
                                            nerd-icons-ibuffer
                                            nerd-icons-completion nerd-icons
                                            dashboard smartparens which-key
                                            zzz-to-char goto-line-preview
                                            windresize auto-highlight-symbol
                                            highlight-symbol symbol-overlay mwim
                                            pulsar yascroll magit popup
                                            rainbow-delimiters god-mode minimap
                                            drag-stuff popwin ace-jump-mode
                                            shackle goggles vundo centaur-tabs
                                            use-package beacon focus treemacs
                                            dirvish)) 
 '(pulsar-delay 0.025) 
 '(treemacs-width 40) 
 '(treemacs-width-is-initially-locked nil) 
 '(yascroll:delay-to-hide 1))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t 
             (:inherit nil 
                       :extend nil 
                       :stipple nil 
                       :background "white" 
                       :foreground "#37474F" 
                       :inverse-video nil 
                       :box nil 
                       :strike-through nil 
                       :overline nil 
                       :underline nil 
                       :slant normal 
                       :weight light 
                       :height 125 
                       :width normal 
                       :foundry "GOOG" 
                       :family "RobotoMono Nerd Font")))) 
 '(ahs-definition-face ((t 
                         (:background "light steel blue" 
                                      :foreground "black" 
                                      :weight normal)))) 
 '(ahs-definition-face-unfocused ((t 
                                   (:background "light steel blue" 
                                                :foreground "black" 
                                                :weight normal)))) 
 '(ahs-face ((t 
              (:background "gray90" 
                           :weight normal)))) 
 '(ahs-face-unfocused ((t 
                        (:background "gray90" 
                                     :weight normal)))) 
 '(ahs-plugin-default-face ((t 
                             (:background "gray97" 
                                          :foreground "black")))) 
 '(ahs-plugin-default-face-unfocused ((t 
                                       (:background "gray97" 
                                                    :foreground "black")))) 
 '(aw-background-face ((t nil))) 
 '(aw-leading-char-face ((t 
                          (:extend t 
                                   :background "white" 
                                   :foreground "red" 
                                   :box (:line-width (2 . 2) 
                                                     :color "red" 
                                                     :style released-button) 
                                   :weight extra-bold 
                                   :height 3.0)))) 
 '(centaur-tabs-active-bar-face ((t 
                                  (:background "red2" 
                                               :foreground "white" 
                                               :weight normal)))) 
 '(centaur-tabs-selected ((t 
                           (:background "red2" 
                                        :foreground "white" 
                                        :underline nil 
                                        :weight semi-light)))) 
 '(centaur-tabs-selected-modified ((t 
                                    (:background "darkgoldenrod2" 
                                                 :foreground "white" 
                                                 :overline nil 
                                                 :underline nil 
                                                 :weight normal)))) 
 '(centaur-tabs-unselected ((t 
                             (:background "gainsboro" 
                                          :foreground "#3d3c3d")))) 
 '(centaur-tabs-unselected-modified ((t 
                                      (:background "gainsboro" 
                                                   :foreground "red3" 
                                                   :weight normal)))) 
 '(diff-hl-margin-change ((t 
                           (:foreground "RoyalBlue3" 
                                        :background "RoyalBlue3" 
                                        :extend nil 
                                        :inherit diff-hl-change)))) 
 '(diff-hl-margin-delete ((t 
                           (:foreground "red3" 
                                        :background "red3" 
                                        :extend nil 
                                        :inherit diff-hl-delete)))) 
 '(diff-hl-margin-insert ((t 
                           (:foreground "green3" 
                                        :background "green3" 
                                        :extend nil 
                                        :inherit diff-hl-insert)))) 
 '(diff-hl-margin-unknown ((t 
                            (:foreground "gainsboro" 
                                         :background "gainsboro" 
                                         :extend nil 
                                         :inherit dired-ignored)))) 
 '(minimap-active-region-background ((t 
                                      (:extend t 
                                               :background "gray93")))) 
 '(minimap-current-line-face ((t 
                               (:extend t 
                                        :background "red1" 
                                        :foreground "white")))) 
 '(nano-face-faded ((t 
                     (:foreground "#B0BEC5" 
                                  :weight thin))) t) 
 '(popup-isearch-match ((t 
                         (:background "white" 
                                      :foreground "red2")))) 
 '(popup-menu-face ((t 
                     (:background "white" 
                                  :inherit popup-face)))) 
 '(popup-menu-mouse-face ((t 
                           (:background "gainsboro" 
                                        :foreground "black")))) 
 '(popup-menu-selection-face ((t 
                               (:weight normal 
                                        :foreground "white" 
                                        :background "red2" 
                                        :inherit default)))) 
 '(popup-menu-summary-face ((t 
                             (:background "white" 
                                          :inherit popup-summary-face)))) 
 '(popup-scroll-bar-background-face ((t nil))) 
 '(popup-scroll-bar-foreground-face ((t nil))) 
 '(popup-summary-face ((t 
                        (:foreground "dimgray" 
                                     :background "white" 
                                     :inherit popup-face)))) 
 '(popup-tip-face ((t 
                    (:background "red2" 
                                 :foreground "white" 
                                 :slant italic)))) 
 '(pulsar-generic ((t 
                    (:extend t 
                             :background "gray" 
                             :foreground "white" 
                             :weight normal)))) 
 '(pulsar-green ((t 
                  (:extend t 
                           :background "green2" 
                           :foreground "white" 
                           :weight normal)))) 
 '(pulsar-red ((t 
                (:extend t 
                         :background "red1" 
                         :foreground "white" 
                         :weight normal)))) 
 '(pulsar-yellow ((t 
                   (:extend t 
                            :background "goldenrod1" 
                            :foreground "white" 
                            :weight normal)))) 
 '(pulse-highlight-start-face ((t 
                                (:background "gray")))) 
 '(tooltip ((t 
             (:height 0.75 
                      :box (:line-width (2 . 2) 
                                        :color "grey75" 
                                        :style released-button) 
                      :foreground "black" 
                      :background "white smoke" 
                      :inherit variable-pitch)))) 
 '(treemacs-directory-collapsed-face ((t 
                                       (:weight light 
                                                :foreground "black" 
                                                :inherit treemacs-directory-face)))) 
 '(treemacs-directory-face ((t 
                             (:weight light 
                                      :foreground "black" 
                                      :inherit font-lock-function-name-face)))) 
 '(treemacs-file-face ((t 
                        (:foreground "gray20" 
                                     :inherit default)))) 
 '(treemacs-git-added-face ((t 
                             (:foreground "green3" 
                                          :inherit font-lock-type-face)))) 
 '(treemacs-git-ignored-face ((t 
                               (:weight thin 
                                        :foreground "dim gray" 
                                        :inherit font-lock-comment-face)))) 
 '(treemacs-git-modified-face ((t 
                                (:foreground "dark slate blue" 
                                             :inherit
                                             font-lock-variable-name-face)))) 
 '(treemacs-git-renamed-face ((t 
                               (:weight normal 
                                        :foreground "DarkSlateBlue" 
                                        :inherit font-lock-doc-face)))) 
 '(treemacs-git-untracked-face ((t 
                                 (:weight normal 
                                          :foreground "red2" 
                                          :inherit font-lock-string-face)))) 
 '(treemacs-marked-file-face ((t 
                               (:background "red3" 
                                            :foreground "white" 
                                            :weight bold)))) 
 '(treemacs-nerd-icons-file-face ((t 
                                   (:inherit nerd-icons-dsilver)))) 
 '(treemacs-nerd-icons-root-face ((t 
                                   (:inherit nerd-icons-silver)))) 
 '(treemacs-root-face ((t 
                        (:height 1.0 
                                 :weight bold 
                                 :box (:line-width (1 . 1) 
                                                   :color "grey75" 
                                                   :style flat-button) 
                                 :foreground "black" 
                                 :inherit font-lock-constant-face)))) 
 '(treemacs-term-node-face ((t 
                             (:foreground "SteelBlue4" 
                                          :extend t 
                                          :inherit font-lock-string-face)))) 
 '(yascroll:thumb-fringe ((t 
                           (:background "gray24" 
                                        :foreground "gray24")))) 
 '(yascroll:thumb-text-area ((t 
                              (:background "gray24")))))
