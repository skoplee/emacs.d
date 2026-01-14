;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 用consult切换buffer
(global-set-key (kbd "C-x b") 'consult-buffer)

;; 删除整行
(global-set-key (kbd "C-k") 'kill-whole-line)

;; org-agenda setting
(global-set-key (kbd "C-c a") 'org-agenda)

;; 提示按键下一步
(use-package which-key
  :hook (after-init . which-key-mode)
  :ensure t
  :init
  (setq which-key-side-window-location 'bottom))


(use-package general
  :init
  (general-emacs-define-key 'global [remap imenu] 'consult-imenu)
  (general-emacs-define-key 'global [remap apropos] 'consult-apropos)
  (global-definer
    "!" 'shell-command
    ":" 'eval-expression
    "SPC" 'execute-extended-command
    "x" 'switch-to-scratch-buffer
    "TAB" 'spacemacs/alternate-buffer
    "'" 'vertico-repeat
    "=" 'indent-buffer
    "+" 'text-scale-increase
    "-" 'text-scale-decrease
    "u" 'universal-argument
    "v" 'er/expand-region
    "0" 'select-window-0
    "1" 'select-window-1
    "2" 'select-window-2
    "3" 'select-window-3
    "4" 'select-window-4
    "5" 'select-window-5
    ";" 'vterm
    "`" 'multi-vterm-project
    "hdf" 'describe-function
    "hdv" 'describe-variable
    "hdk" 'describe-key
    "qq" 'save-buffers-kill-terminal
    "qR" 'restart-emacs
    "hh" 'zilongshanren/highlight-dwim
    "hc" 'zilongshanren/clearn-highlight
    "en" 'my-goto-next-error
    "ry" 'consult-yank-pop
    "R" 'zilongshanren/run-current-file
    "ep" 'my-goto-previous-error
    "el" 'my-list-errors
    "oy" 'my/eudic
    "oo" 'zilongshanren/hotspots
    "or" 'org-roam-node-find
    "gs" 'magit-status
    "gd" 'vc-diff
    "gg" 'xref-find-definitions
    "gr" 'xref-find-references
    "gm" 'consult-mark
    "gM" 'consult-global-mark
    )

  (+general-global-menu! "search" "s"
    "p" 'consult-ripgrep
    "k" 'consult-keep-lines
    "f" 'consult-focus-lines)


  (+general-global-menu! "buffer" "b"
    "d" 'kill-current-buffer
    "b" '(consult-buffer :which-key "consult buffer")
    "B" 'switch-to-buffer
    "p" 'previous-buffer
    "R" 'rename-buffer
    "M" '((lambda () (interactive) (switch-to-buffer "*Messages*"))
          :which-key "messages-buffer")
    "n" 'next-buffer
    "i" 'ibuffer
    "f" 'my-open-current-directory
    "k" 'kill-buffer
    "y" 'copy-buffer-name
    "K" 'kill-other-buffers)

  (+general-global-menu! "layout" "l"
    "l" 'tabspaces-switch-or-create-workspace
    "L" 'tabspaces-restore-session
    "p" 'tabspaces-open-or-create-project-and-workspace
    "f" 'tabspaces-project-switch-project-open-file
    "s" 'tabspaces-save-session
    "B" 'tabspaces-switch-buffer-and-tab
    "b" 'tabspaces-switch-to-buffer
    "R" 'tab-rename
    "TAB" 'tab-bar-switch-to-recent-tab
    "r" 'tabspaces-remove-current-buffer
    "k" 'tabspaces-close-workspace)

  (+general-global-menu! "file" "f"
    "f" 'find-file
    "r" 'consult-recent-file
    "L" 'consult-locate
    "d" 'consult-dir
    "ed" 'open-my-init-file
    "s" 'save-buffer
    "w" 'sudo-edit
    "S" 'save-some-buffers
    "j"  'dired-jump
    "y" 'copy-file-name)


  (+general-global-menu! "window" "w"
    "/" 'split-window-right
    "-" 'split-window-below
    "m" 'delete-other-windows
    "u" 'winner-undo
    "z" 'winner-redo
    "w" 'esw/select-window
    "s" 'esw/swap-two-windows
    "d" 'esw/delete-window
    "=" 'balance-windows-area
    "r" 'esw/move-window
    "x" 'resize-window
    "H" 'buf-move-left
    "L" 'buf-move-right
    "J" 'buf-move-down
    "K" 'buf-move-up)

  (+general-global-menu! "toggle" "t"
    "s" 'flycheck-mode
    "S" 'flyspell-prog-mode
    "e" 'toggle-corfu-english-helper
    "r" 'read-only-mode
    "n" 'my-toggle-line-numbber
    "w" 'distraction-free
    "k" '+toggle-keycast
    "c" 'global-corfu-mode
    "m" 'consult-minor-mode-menu)

  (+general-global-menu! "project" "p"
    "f" 'project-find-file
    "r" 'consult-recent-file
    "s" 'project-find-regexp
    "d" 'project-dired
    "b" 'consult-project-buffer
    "e" 'project-eshell
    "m" 'my/project-run-makefile-target
    "c" 'project-compile
    "t" 'my/project-citre
    "p" 'project-switch-project
    "i" 'my/project-info
    "a" 'project-remember-projects-under
    "x" 'project-forget-project)
  (global-leader
    ;; :states '(normal insert emacs)
    "e" 'skop-smart-bing-dict)
  )

;;
(provide 'init-keybindings)
