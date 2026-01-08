;;; 	keycast: 在 modeline 显示按键和命令
;;	vertico: 垂直补全框架
;;	orderless: 灵活的补全样式
;;	marginalia: 在 minibuffer 中显示额外信息
;;	embark: 上下文操作框架
;;	embark-consult: embark 与 consult 的集成


(use-package vertico
  :init
  (vertico-mode t))

(use-package orderless
  :init
  (setq completion-styles '(orderless)))

(use-package marginalia
  :init
  (marginalia-mode t))

(use-package embark
  :bind
  (("C-;" . embark-act))
  :init
  (setq embark-quit-after-action '((kill-buffer . nil))))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-c f" . consult-imenu)))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

(use-package company
  :init
  (global-company-mode t)
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0))

;; file end--------------
(provide 'init-tools)
