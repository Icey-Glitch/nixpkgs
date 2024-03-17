{ lib
, symlinkJoin
, etlegacy-assets
, etlegacy-base
, makeBinaryWrapper
}:

symlinkJoin {
  name = "etlegacy";
  version = "2.82.0";
  paths = [
    etlegacy-assets
    etlegacy-base
  ];

  nativeBuildInputs = [
    makeBinaryWrapper
  ];

  postBuild = ''
    rm -rf $out/bin/*
    makeWrapper ${etlegacy-base}/bin/etl.* $out/bin/etl \
      --add-flags "+set fs_basepath ${placeholder "out"}/lib/etlegacy"
    makeWrapper ${etlegacy-base}/bin/etlded.* $out/bin/etlded \
      --add-flags "+set fs_basepath ${placeholder "out"}/lib/etlegacy"
  '';

  meta = {
    description = "ET: Legacy is an open source project based on the code of Wolfenstein: Enemy Territory which was released in 2010 under the terms of the GPLv3 license";
    homepage = "https://etlegacy.com";
    license = with lib.licenses; [ gpl3Plus cc-by-nc-sa-30 ];
    longDescription = ''
      ET: Legacy, an open source project fully compatible client and server
      for the popular online FPS game Wolfenstein: Enemy Territory - whose
      gameplay is still considered unmatched by many, despite its great age.
    '';
    mainProgram = "etl";
    maintainers = with lib.maintainers; [ ashleyghooper drupol ];
    platforms = lib.platforms.linux;
  };
}
