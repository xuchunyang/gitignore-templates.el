;;; gitignore-templates.el --- Access GitHub .gitignore templates  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Xu Chunyang

;; Author: Xu Chunyang <mail@xuchunyang.me>
;; Homepage: https://github.com/xuchunyang/gitignore-templates.el
;; Keywords: tools
;; Package-Requires: ((emacs "24.3"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; https://developer.github.com/v3/gitignore/

;;; Code:

(require 'json)
(require 'url)

(defvar url-http-end-of-headers)

(defvar gitignore-templates-names nil
  "List of names of available templates.")

(defvar gitignore-templates-alist nil
  "List of (name . content).")

(defun gitignore-url-to-string (url)
  (with-current-buffer (url-retrieve-synchronously url)
    (prog1 (buffer-substring (1+ url-http-end-of-headers)
                             (point-max))
      (kill-buffer))))

(defun gitignore-templates-names ()
  "Return list of names of available templates."
  (unless gitignore-templates-names
    (setq gitignore-templates-names
          (split-string
           (gitignore-url-to-string "https://www.gitignore.io/api/list")
           "[,\n]" t)))
  gitignore-templates-names)

(defun gitignore-templates (name)
  "Return .gitignore template for NAME."
  (unless (member name (gitignore-templates-names))
    (user-error "Invaild template name %s" name))
  (gitignore-url-to-string (concat "https://www.gitignore.io/api/"
                                   name)))

;;;###autoload
(defun gitignore-templates-insert (name)
  "Insert .gitignore template for NAME."
  (interactive
   (list (completing-read ".gitignore template: "
                          (gitignore-templates-names)
                          nil t)))
  (insert (gitignore-templates name)))

;;;###autoload
(defun gitignore-templates-new-file (name &optional directory)
  "Create a .gitignore file for NAME in DIRECTORY.
With a prefix argument prompt for a directory to use.
If DIRECTORY is nil, use `default-directory'."
  (interactive
   (list (completing-read ".gitignore template: "
                          (gitignore-templates-names)
                          nil t)
         (if current-prefix-arg
             (read-directory-name "Creat .gitignore in directory: ")
           default-directory)))
  (let ((file (expand-file-name ".gitignore" directory)))
    (when (file-exists-p file)
      (user-error "Can't create '%s', because it already exists"
                  (abbreviate-file-name file)))
    (write-region (gitignore-templates name) nil file)))

(provide 'gitignore-templates)
;;; gitignore-templates.el ends here
