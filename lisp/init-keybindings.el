;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 用consult切换buffer
(global-set-key (kbd "C-x b") 'consult-buffer)

;; 删除整行
(global-set-key (kbd "C-k") 'kill-whole-line)

;;
(provide 'init-keybindings)
