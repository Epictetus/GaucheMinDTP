#!/usr/bin/env gosh

(use srfi-1)
(use srfi-13)
(use gauche.collection)
(use rfc.http)
(use rfc.uri)


(define (error-exit . msg)
  (apply format (cons (current-error-port) msg))
  (exit -1))

(define (usage)
  (error-exit "Usage: ~a URL PDF-FILE\n" *program-name*))

(define (full-path path)
  (if (eq? (string-ref path 0) #\/)
      path
      (string-append (current-directory) "/" (simplify-path path))))

(define (get-link-page url)
  (rxmatch-let
      (rxmatch #/\/\/(.*?)(\/.*)$/ url)
      (d host path)
    (receive 
	(status header body) 
	(http-get host path)
      (if (string= status "200")
	  body
	  (error-exit #`"not found ,url")))))

(define (link-url-list html)
  (define (link-urls html urls)
    (cond ((rxmatch #/<li>.*?<a href=\"(.*?)\">/ html) =>
	   (lambda(m) (link-urls (rxmatch-after m) (cons (m 1) urls))))
	  (else urls)))
  (reverse (link-urls html ())))

(define (full-url url base-url)
  (rxmatch-let
      (rxmatch #/^.*\// base-url)
      (url-top)
    (string-append url-top url)))

(define (full-url-with-a-opt url base-url)
  (string-append "'" (full-url url base-url) "&a=1'"))
    
(define (genrate-pdf urls pdf-file)
  (let1 cmd #`"wkhtmltopdf --no-background --grayscale --footer-center '[page]' -L 25 -R 15 -T 15 -B 15 -s A4 --footer-spacing 5 toc --xsl-style-sheet toc.xsl ,(string-join urls) ,pdf-file"
    (display cmd)
    (display "\n")
    (sys-system cmd)))

(define (main args)
  (if (< (length args) 3)
      (usage))
  (let* ((top-url (second args))
	 (html (get-link-page top-url))
	 (page-urls (map (lambda(url) (full-url-with-a-opt url top-url))
			 (link-url-list html))))
    (genrate-pdf page-urls (third args))))

	     