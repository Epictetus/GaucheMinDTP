#!/opt/local/bin/gosh

(use wiliki)

;; Customization:
;;
;;  (1) Change the #!-line on top to point gosh's path at your site.
;;  (2) Tailor keyword arguments after 'make <wiliki>'.
;;
;;    :db-path - A path to the dbm database.  If it's relative, it's
;;               relative to the directory the CGI script exists.
;;               I recommend to put the database outside the directory
;;               tree accessible via http.
;;               The database is automatically created when accessed
;;               first time; make sure the data directory is writable
;;               by the CGI script only for the first time.
;;
;;    :top-page - The name of the top page.  If the named page doesn't
;;               exist, it is created for the first time it accessed.
;;
;;    :title    - The name of your WiLiKi site.  A string given here
;;               is used in some places, like in the title of the 
;;               "Search results" or "Recent changes" pages.
;;
;;    :description - A short description of this Wiki site.  This is
;;               used in RDF site summary.
;;
;;    :editable? - If #f, editing is prohibited.
;;
;;    :language - default language, either 'jp or 'en
;;
;;    :style-sheet - If a path to the css is given, it is used as a
;;               style sheet.  #f to use the default style.
;;
;;    :alter-style-sheet - alternative style sheet path.
;;
;;    :charsets - specify assoc list of character encodings to be
;;               used to generate webpage.
;;
;;    :image-urls - specify which URL is allowed as an in-line image.
;;
;;    :db-type - A class that implements database functions;
;;               Default is <gdbm>.  I think <odbm> and <ndbm> should
;;               work, although they might have a problem in locking
;;               the database.  You can also define your database class
;;               and implement wdb* methods (see wiliki.scm).
;;               Don't add this argument if you're not sure about these stuff.
;;
;;    :debug-level - if more than 0, wiliki shows diagnostic messages when
;;               it encounters an error during processing (including macro
;;               expansion error).  Useful while debugging, but should be
;;               turned off for the sites open to public.

(define (main args)
  (wiliki-main
   (make <wiliki>
     :db-path "/opt/local/apache2/data/wiliki.dbm"
     :log-file "../cgi-logs/wiliki.log"
     :top-page "WiLiKi"
     :title "MyWiliki"
     :description "My Wiliki Site"
     :style-sheet "/css/wiliki.css"
     :alter-style-sheet "/css/wiliki_dtp.css"
     :language 'jp
     :charsets '((jp . utf-8) (en . utf-8))
     :image-path "/wiliki/images"
     :debug-level 0
     )))

;; Local variables:
;; mode: scheme
;; end:

