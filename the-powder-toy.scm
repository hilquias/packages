(use-modules (gnu packages algebra)
	     (gnu packages compression)
	     (gnu packages curl)
	     (gnu packages lua)
	     (gnu packages sdl)
	     (guix packages)
	     (guix git-download)
	     (guix build-system scons)
	     ((guix licenses)
	      #:prefix license:))

(package
 (name "the-powder-toy")
 (version "95.0")
 (source
  (origin
   (method git-fetch)
   (uri
    (git-reference
     (url "https://github.com/The-Powder-Toy/The-Powder-Toy.git")
     (commit
      (string-append "v" version))))
   (file-name
    (git-file-name name version))
   (sha256
    (base32
     "0c329awnmnry4pmfla04kfj9j7m0fjnbaflvv2j4m5vl1ic0rvfi"))))
 (build-system scons-build-system)
 (arguments
  `(#:tests? #f
    #:phases
    (modify-phases %standard-phases
      (replace 'install
        (lambda*
	    (#:key outputs #:allow-other-keys)
	  (let*
	      ((out
		(assoc-ref outputs "out"))
	       (bin
		(string-append out "/bin")))
	    (mkdir-p bin)
	    (install-file "./build/powder64" bin)))))))
 (inputs `(("bzip2" ,bzip2)
	   ("curl" ,curl)
	   ("fftwf" ,fftwf)
	   ("lua" ,lua-5.1)
	   ("sdl2" ,sdl2)
	   ("zlib" ,zlib)))
 (home-page "")
 (synopsis "")
 (description "")
 (license license:gpl3))
