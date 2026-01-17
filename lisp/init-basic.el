;; 括号匹配
(show-paren-mode t)	
;;	  
(setq-default tab-width 4)
(define-key input-decode-map [(control ?i)] [control-i])
;;(define-key input-decode-map [(control ?I)] [(shift control-i)])
;;(global-set-key (kbd "<control-i>") 'forward-word)
;;(global-set-key (kbd "<control-i>") 'self-insert-command)
(global-set-key (kbd "<control-i>")
				(lambda ()
				  (interactive)
				  (insert "\t")))

;; 禁用启动画面后会自动打开 scratch 缓冲区
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;; 关闭edoc
(global-eldoc-mode -1)

;; yes or no --> 'y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; 关闭~备份文件
(setq make-backup-files nil)
(setq make-save-default nil)
(setq auto-save-default nil)

;; 输入替换选中
(delete-selection-mode t)

;; 让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; 同步文件内容
(global-auto-revert-mode t)


;; 记住最近打开的文件
(use-package recentf
  :hook (after-init . recentf-mode)
  ;; recentf-open since v29.1, recentf-open-files since v22
  :bind (("C-c r" . #'recentf-open)))


;; 记住上次的命令
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300))

;; 记住光标位置
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))


;; 自存内容
(setq custom-file (expand-file-name "~/.emacs.d/lisp/custom.el"))
(load custom-file 'no-error 'no-message)

;; general setting
(use-package general
  :init
  (with-eval-after-load 'evil
    (general-add-hook 'after-init-hook
		      (lambda (&rest _)
			(when-let ((messages-buffer (get-buffer "*Messages*")))
			  (with-current-buffer messages-buffer
			    (evil-normalize-keymaps))))
		      nil
		      nil
		      t))

    (general-create-definer global-definer
    :keymaps 'override
    :states '(insert emacs normal hybrid motion visual operator)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

      (defmacro +general-global-menu! (name infix-key &rest body)
    "Create a definer named +general-global-NAME wrapping global-definer.
Create prefix map: +general-global-NAME. Prefix bindings in BODY with INFIX-KEY."
    (declare (indent 2))
    `(progn
       (general-create-definer ,(intern (concat "+general-global-" name))
         :wrapping global-definer
         :prefix-map ',(intern (concat "+general-global-" name "-map"))
         :infix ,infix-key
         :wk-full-keys nil
         "" '(:ignore t :which-key ,name))
       (,(intern (concat "+general-global-" name))
        ,@body)))

      (general-create-definer global-leader
    :keymaps 'override
    :states '(emacs normal hybrid motion visual operator)
    :prefix ","
    "" '(:ignore t :which-key (lambda (arg) `(,(cadr (split-string (car arg) " ")) . ,(replace-regexp-in-string "-mode$" "" (symbol-name major-mode)))))))

;;
(provide 'init-basic)
