;;; robby-api-key.el  --- functions for getting robby's OpenAi key  -*- lexical-binding:t -*-

;;; Commentary:

;; functions and customization variables for managing robby's OpenAI key

;;; Code:
(require 'auth-source)

;; declared in robby-customization.el
(defvar robby-openai-api-key)

;; declared in robby-providers.el
(declare-function robby--provider-host ())

(defun robby--get-api-key-from-auth-source ()
  "Get api key from auth source."
  (if-let ((secret (plist-get (car (auth-source-search
                                    :host (robby--provider-host)
                                    :user "apikey"
                                    :require '(:secret)))
                              :secret)))
      (if (functionp secret)
          (encode-coding-string (funcall secret) 'utf-8)
        secret)
    (user-error "No `robby-api-key' found in auth source")))

(defun robby--get-api-key ()
  "Get api key from `robby-api-key'."
  (cond
   ((stringp robby-openai-api-key) robby-openai-api-key)
   ((functionp robby-openai-api-key) (funcall robby-openai-api-key))
   (t (error "`robby-openai-api-key` not set"))))

(provide 'robby-api-key)

;;; robby-api-key.el ends here
