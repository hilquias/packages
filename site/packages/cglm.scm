(define-module (site packages cglm)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages gl))

(define-public cglm
  (package
	(name "cglm")
	(version "0.7.9")
	(source
	 (origin
	   (method url-fetch)
	   (uri
		(string-append "https://github.com/recp/cglm/archive/v" version ".tar.gz"))
	   (sha256
		(base32 "0yxxx4jni75gbx2qvh9bwqcmlqis5byvmrigq1xdpbnry6kdhvf9"))))
	(build-system cmake-build-system)
	(arguments
	 `(#:tests? #f
	   #:phases
       (modify-phases %standard-phases
         (add-after 'install 'cmake-config
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
					(cmake-config-dir (string-append out "/lib/cmake/cglm")))
			   (mkdir-p cmake-config-dir)
			   (install-file "cglmConfig.cmake" cmake-config-dir)
			   #t))))))
	(synopsis "OpenGL Mathematics library for C")
	(description "OpenGL Mathematics for C (CGLM) is a header-only C
mathematics library for graphics software based on the OpenGL Shading
Language (GLSL) specifications.")
	(home-page "https://github.com/recp/cglm")
	(license license:expat)))

cglm
