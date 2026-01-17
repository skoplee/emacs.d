(require 'org-tempo)

;; set tab width
(add-hook 'org-mode-hook
		  (lambda ()
			(setq tab-width 4)))

;;
(setq org-indent-mode 1)

(use-package org-contrib
  :pin nongnu)

;; org-mode的标记
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))

(require 'org-checklist)

;; 将完成的时间折叠
(setq org-log-done t)
(setq org-log-into-drawer t)

;; org-agenda 文件
(setq org-agenda-files '("~/gtd.org"))

;; 设置org-agenda显示为天
(setq org-agenda-span 'day)

;; org capture 模板
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/gtd.org" "Workspace")
         "* TODO [#B] %?\n  %i\n %U"
         :empty-lines 1)))

(global-set-key (kbd "C-c r") 'org-capture)

;; 插入图片,操作图片
(use-package org-download
  :ensure t
  :demand t
  :after org
  :config
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq org-download-screenshot-method "screencapture -i %s")
  (setq org-download-screenshot-file 
	(expand-file-name "screenshot.png" temporary-file-directory))
  (defun org-download-annotate-default (link)
    "Annotate LINK with the time of download."
    (make-string 0 ?\s))

  ;; 其他设置
  (setq-default org-download-heading-lvl nil
		;; 图片保存目录（相对于当前org文件）
                org-download-image-dir "./img"))

;; 解决return按键在orgmode中的问题
(setq org-return-follows-link t)


;; 翻译
(defun skop-smart-bing-dict ()
  (interactive)
  (let ((word (thing-at-point 'word)))
    (if word
        (bing-dict-brief word)
      (call-interactively 'bing-dict-brief))))

(use-package bing-dict
  :ensure t
  :commands (bing-dict-brief))

;; end file
(provide 'init-org)
