{
  stdenv,lib,coreutils,doas,makeWrapper,fetchurl,
}:

stdenv.mkDerivation {
  pname = "doas-keepenv";
  version = "1.0";

  src = fetchurl {
    url = "https://github.com/stas-badzi/doas-keepenv/archive/refs/tags/1.0.tar.gz";
    sha256 = "sha256-qviS2bepd19EUb0eFVHfsUsk3NsocL9q9LUk4KQhvic=";
  };

  buildInputs = [
    doas
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  buildPhase = ''
    echo ZZZZZZZZZZZZZZZZZZZZZZZZZZ...
    sleep 60
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m 755 doas-keepenv $out/bin
    wrapProgram $out/bin/doas-keepenv --prefix PATH : "${
      lib.makeBinPath [
        coreutils
      ]
    }:/run/wrappers/bin/doas"
    # add the doas suid wrappper instead of literal doas
  '';

  meta = {
    description = "A bash script for running the doas command while keeping environment variables";
    homepage = "https://github.com/stas-badzi/doas-keepenv";
    mainProgram = "doas-keepenv";
    license = lib.licenses.mit;
    #maintainers = with lib.maintainers; [ stasbadzi ];
    platforms = lib.platforms.linux;
  };
}
