;; 括号匹配
(show-paren-mode t)

;; 禁用启动画面后会自动打开 scratch 缓冲区
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

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
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

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

;;
(provide 'init-basic)
