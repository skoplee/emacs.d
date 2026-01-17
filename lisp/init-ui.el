;; 显示行号
(global-display-line-numbers-mode t)

;; 关闭滚动条
(scroll-bar-mode -1) 

;; 关闭文件滑动控件
(scroll-bar-mode -1)

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



;; 状态栏主题
(use-package doom-modeline
  :ensure t
;  :custom-face
;  (mode-line ((t (:height 2))))
;  (mode-line-inactive ((t (:height 1.9))))
  :init
  (doom-modeline-mode t))

(use-package keycast
  :hook (after-init . keycast-mode)
  :config
  (define-minor-mode keycast-mode
	"Show current command and its key binding in the mode line (fix for use with doom-modeline)."
	:global t
	(if keycast-mode
		(add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update)))

  (add-to-list 'global-mode-string '("" keycast-mode-line)))


;; file end-------------------
(provide 'init-ui)
