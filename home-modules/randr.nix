{ restart-polybar ? false
, restart-xmonad  ? false
, restart-wal     ? false
, monitors
}:
let
   dell = {
      fingerprint = "00ffffffffffff0010ac7f404c38383122160103803c2278ea4bb5a7564ba3250a5054a54b008100b300714fa9408180010101010101023a801871382d40582c250055502100001e000000ff00474b304b4432384c3138384c0a000000fc0044454c4c205532373133484d0a000000fd00384c1e5111000a2020202020200152020329f15090050403020716010611121513141f2023097f0767030c001000382d83010000e3050301023a801871382d40582c250055502100001e011d8018711c1620582c250055502100009e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e960055502100001800000000000000000000000000007a";
   };
   edp-nv = {
      fingerprint = "00ffffffffffff0030e48b0500000000001a0104a51f1178e25715a150469d290f505400000001010101010101010101010101010101695e00a0a0a029503020a50035ae1000001a000000000000000000000000000000000000000000fe004c4720446973706c61790a2020000000fe004c503134305148322d5350423100b8";
   };
in {
   enable = true;
}
