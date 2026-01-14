;;	vertico: 垂直补全框架
(use-package vertico
  :init
  (vertico-mode t))

;; make c-j/c-k work in vertico selection
(define-key vertico-map (kbd "C-j") 'vertico-next)
(define-key vertico-map (kbd "C-k") 'vertico-previous)

;;	orderless: 灵活的补全样式
(use-package orderless
  :init
  (setq completion-styles '(orderless)))

;;	marginalia: 在 minibuffer 中显示额外信息
(use-package marginalia
  :init
  (marginalia-mode t))

;;	embark: 上下文操作框架
(use-package embark
  :bind
  (("C-;" . embark-act))
  :init
  (setq embark-quit-after-action '((kill-buffer . nil))))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-c f" . consult-imenu)))

;;	embark-consult: embark 与 consult 的集成
(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

;; 补全
(use-package company
  :init
  (global-company-mode t)
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0))

;; eglot 补全
(use-package eglot
  :ensure t
  :hook ((c-ts-mode c++-ts-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode) . ("clangd" "--header-insertion=never"))))

;; 快速调试代码
(use-package quickrun
  :commands (quickrun)
  :config
  (setq quickrun-output-only t)
  :init
  (quickrun-add-command "c/gcc"
    '((:command . "gcc")
      (:exec . ("%c -std=c11 %o -o %e %s"
                "%e %a"))
      (:remove . ("%e")))
    :default "c"))
(global-set-key (kbd "<f5>") 'quickrun)


;; 选中单词后用<C-r>来进行替换操作
(defun skopliuu/evil-quick-replace (beg end )
  (interactive "r")
  (when (evil-visual-state-p)
    (evil-exit-visual-state)
    (let ((selection (regexp-quote (buffer-substring-no-properties beg end))))
      (setq command-string (format "%%s /%s//g" selection))
      (minibuffer-with-setup-hook
          (lambda () (backward-char 2))
        (evil-ex command-string)))))

(define-key evil-visual-state-map (kbd "C-r") 'skopliuu/evil-quick-replace)

;; 语法高量 <https://book.emacs-china.org/#org4dc86a5>
(use-package treesit-auto
  :demand t
  :init
  (setq treesit-font-lock-level 4)
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

;; 代码展开 占位符
(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode)
         (org-mode . yas-minor-mode))
  :init
  :config
  (progn
    (setq hippie-expand-try-functions-list
          '(yas/hippie-try-expand
            try-complete-file-name-partially
            try-expand-all-abbrevs
            try-expand-dabbrev
            try-expand-dabbrev-all-buffers
            try-expand-dabbrev-from-kill
            try-complete-lisp-symbol-partially
            try-complete-lisp-symbol))))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; 顶部标签页
(use-package tab-bar
  :ensure nil
  :init
  (tab-bar-mode t)
  (setq tab-bar-new-tab-choice "*scratch*") ;; buffer to show in new tabs
  (setq tab-bar-close-button-show nil)      ;; hide tab close / X button
  (setq tab-bar-show 1)                     ;; hide bar if <= 1 tabs open
  (setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

  (custom-set-faces
   '(tab-bar ((t (:inherit mode-line))))
   '(tab-bar-tab ((t (:inherit mode-line :foreground "#A2E4B8"))))
   '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive :foreground "mint")))))

  (defvar ct/circle-numbers-alist
    '((0 . "⓪")
      (1 . "①")
      (2 . "②")
      (3 . "③")
      (4 . "④")
      (5 . "⑤")
      (6 . "⑥")
      (7 . "⑦")
      (8 . "⑧")
      (9 . "⑨"))
    "Alist of integers to strings of circled unicode numbers.")

  (defun ct/tab-bar-tab-name-format-default (tab i)
    (let ((current-p (eq (car tab) 'current-tab))
          (tab-num (if (and tab-bar-tab-hints (< i 10))
                       (alist-get i ct/circle-numbers-alist) "")))
      (propertize
       (concat tab-num
               " "
               (alist-get 'name tab)
               (or (and tab-bar-close-button-show
                        (not (eq tab-bar-close-button-show
                                 (if current-p 'non-selected 'selected)))
                        tab-bar-close-button)
                   "")
               " ")
       'face (funcall tab-bar-tab-face-function tab))))
  (setq tab-bar-tab-name-format-function #'ct/tab-bar-tab-name-format-default)
  (setq tab-bar-tab-hints t))

;; 对tab的操作 tabspaces-...
(use-package tabspaces
  ;; use this next line only if you also use straight, otherwise ignore it.
  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup.
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  ;; maybe slow
  ;; (tabspaces-session t)
  ;; (tabspaces-session-auto-restore t)
  :config
  ;; Filter Buffers for Consult-Buffer

  (with-eval-after-load 'consult
    ;; hide full buffer list (still available with "b" prefix)
    (consult-customize consult--source-buffer :hidden nil :default nil)
    ;; set consult-workspace buffer list
    (defvar consult--source-workspace
      (list :name "Workspace Buffers"
            :narrow ?w
            :history 'buffer-name-history
            :category 'buffer
            :state #'consult--buffer-state
            :default t
            :items (lambda () (consult--buffer-query
                               :predicate #'tabspaces--local-buffer-p
                               :sort 'visibility
                               :as #'buffer-name)))

      "Set workspace buffer list for consult-buffer.")
    (add-to-list 'consult-buffer-sources 'consult--source-workspace)))

;; 头文件和源文件之间进行跳转
;; ff-find-related-file



(general-create-definer my-leader-def
  ;; :prefix my-leader
  :prefix ",")

;; file end--------------
(provide 'init-tools)
