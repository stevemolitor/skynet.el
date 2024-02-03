;;; robby-grounding-fns.el  --- robby grounding functions  -*- lexical-binding:t -*-

;;; Commentary:

;; A robby grounding filters the response from AI before presenting it to the user.

;;; Code:

(defun robby-extract-fenced-text (response)
  (with-temp-buffer
    (insert response)
    (goto-char (point-min))
    (let ((beg (re-search-forward "```.*$" nil t))
          (end (re-search-forward "```" nil t)))
      (if (and beg end)
          (buffer-substring-no-properties (+ beg 1) (- end 3))
        response))))

(defun robby-extract-fenced-text-in-prog-modes (response)
  (if (derived-mode-p 'prog-mode)
      (robby-extract-fenced-text response)
    response))

(defun robby-format-message-text (response)
  "Replace % with %% in TEXT to avoid format string errors calling `message."
  (replace-regexp-in-string "%" "%%" response))

(defun robby-remove-trailing-end-of-line (string)
  "Remove the end of line character at the very end of a string if present."
  (replace-regexp-in-string "
$" "" string))

(provide 'robby-grounding-fns)

;; robby-grounding-fns.el ends here
