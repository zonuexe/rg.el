;;; test-helper.el --- rg.el: Helper for tests

;; Copyright (C) 2017 David Landell <david.landell@sunnyhill.email>
;;
;; Author: David Landell <david.landell@sunnyhill.email>
;; Homepage: https://github.com/davja/rg.el

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;;; Commentary:

;;; Code:

(require 'ert)
(require 'noflet)
(require 'rg)
(require 's)

(defun regexp-anywhere (needle)
  (s-replace "%%%%" needle "\\( \\|^\\)%%%%\\( \\|$\\)"))

(defun regexp-last (needle)
  (s-replace "%%%%" needle "\\( \\|^\\)%%%%$"))

(defun regexp-anywhere-but-last (needle)
  (s-replace "%%%%" needle "\\( \\|^\\)%%%% "))

(defun rg-wait-for-search-result ()
"Wait for the rg search to finish and returns non nil if the search
was successful. Timeout is 10 s."
  (let (search-finished)
    (add-hook 'compilation-finish-functions
              (lambda (buffer msg) (setq search-finished msg))
              t t)
    (with-timeout (10 nil)
      (while (not search-finished)
        (accept-process-output nil 0.1)))
    (equal (s-trim search-finished) "finished")))

(provide 'test-helper)

;;; test-helper.el ends here