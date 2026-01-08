;; 显示行号
(global-display-line-numbers-mode t)

;; 关闭文件滑动控件
(scroll-bar-mode 1)

;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 更改光标的样式
(setq-default cursor-type 'bar)

;; 高量当前行
(global-hl-line-mode t)

;; gruvbox setting
(use-package gruvbox-theme
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'gruvbox-dark-hard t)

  ;; 自定义-->注释和选择的颜色
  (custom-set-faces
   '(font-lock-comment-face ((t (:foreground "#458588" :background unspecified)))) ;#ffd700
   '(region ((t (:background "#458588" :foreground "#ffd700"))))))

;; 状态栏文件大小
(use-package simple
  :ensure nil
  :hook (after-init . size-indication-mode)
  :init
  (progn
    (setq column-number-mode t)))

;; 状态栏显示按键
(use-package keycast
  :config
  (keycast-mode-line-mode t))

;; 状态栏主题
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode t))


;; file end-------------------
(provide 'init-ui)
