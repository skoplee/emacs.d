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
  :hook ((c-ts-mode c++-mode) . eglot-ensure)
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


;; 头文件和源文件之间进行跳转
;; ff-find-related-file


;; file end--------------
(provide 'init-tools)
