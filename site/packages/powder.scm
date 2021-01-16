(define-module (site packages powder)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system scons)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages sdl))

(define-public powder
  (package
	(name "powder")
	(version "95.0")
	(source
	 (origin
	   (method git-fetch)
	   (uri (git-reference
			 (url "https://github.com/The-Powder-Toy/The-Powder-Toy.git")
			 (commit (string-append "v" version))))
	   (file-name
		(git-file-name name version))
	   (sha256
		(base32 "0c329awnmnry4pmfla04kfj9j7m0fjnbaflvv2j4m5vl1ic0rvfi"))))
	(build-system scons-build-system)
	(inputs
	 `(("bzip2" ,bzip2)
	   ("curl" ,curl)
	   ("fftwf" ,fftwf)
	   ("lua" ,lua-5.1)
	   ("sdl2" ,sdl2)
	   ("zlib" ,zlib)))
	(arguments
	 `(#:tests? #f
	   #:phases
	   (modify-phases %standard-phases
		 (replace 'install
		   (lambda* (#:key outputs #:allow-other-keys)
			 (let* ((out (assoc-ref outputs "out"))
					(bin (string-append out "/bin")))
			   (mkdir-p bin)
			   (install-file "./build/powder64" bin)))))))
	(synopsis "Physics sandbox game")
	(description "The Powder Toy is a free physics sandbox game, which
simulates air pressure and velocity, heat, gravity and a countless
number of interactions between different substances.")
	(home-page "https://powdertoy.co.uk/")
	(license license:gpl3)))

powder
