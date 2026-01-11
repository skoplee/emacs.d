(require 'org-tempo)

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



;; end file
(provide 'init-org)
