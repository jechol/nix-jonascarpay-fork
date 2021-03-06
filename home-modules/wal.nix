{ pkgs, ... }:
let
  pyPkgs = pkgs.python3Packages;
  colorz = pyPkgs.buildPythonPackage rec {
    pname = "colorz";
    version = "1.0.3";
    propagatedBuildInputs = with pyPkgs; [ numpy pillow scipy ];
    src = pyPkgs.fetchPypi {
      inherit pname version;
      sha256 = "0ghd90lgplf051fs5n5bb42zffd3fqpgzkbv6bhjw7r8jqwgcky0";
    };
  };
  haishoku = pyPkgs.buildPythonPackage rec {
    pname = "haishoku";
    version = "1.1.8";
    propagatedBuildInputs = with pyPkgs; [ pillow ];
    src = pyPkgs.fetchPypi {
      inherit pname version;
      sha256 = "1m6bzxlm4pfdpjr827k1zy9ym3qn411lpw5wiaqq2q2q0d6a3fg4";
    };
  };
  pywalfox = pyPkgs.buildPythonPackage rec {
    pname = "pywalfox";
    version = "2.6";
    # propagatedBuildInputs = with pyPkgs; [ pillow ];
    src = pyPkgs.fetchPypi {
      inherit pname version;
      sha256 = "0aci5npfzhgwz8smmbnmqbj524bj9ysgx5ny89q9l28cpisngc4n";
    };
  };

  epatch = pkgs.writeText "emacspatch" ''
    diff --git a/pywal/templates/colors.Xresources b/pywal/templates/colors.Xresources
    index 018c1e6..2b5f492 100644
    --- a/pywal/templates/colors.Xresources
    +++ b/pywal/templates/colors.Xresources
    @@ -1,11 +1,5 @@
     ! X colors.
     ! Generated by 'wal'
    -*foreground:        {foreground}
    -*background:        {background}
    -*.foreground:       {foreground}
    -*.background:       {background}
    -emacs*foreground:   {foreground}
    -emacs*background:   {background}
     URxvt*foreground:   {foreground}
     XTerm*foreground:   {foreground}
     UXTerm*foreground:  {foreground}
  '';

  mywal = pyPkgs.pywal.overrideAttrs (old: {
    propagatedBuildInputs = old.propagatedBuildInputs ++ [ colorz haishoku ];
    patches = old.patches ++ [ epatch ];
  });
in
{
  home.packages = [ mywal pywalfox ];
  xsession.initExtra = ''
    wal -i ~/Wallpapers/papes --backend haishoku
  '';
  programs.autorandr.hooks.postswitch.restart-wal = ''
    wal -i "$(cat /home/jmc/.cache/wal/wal)" -R
  '';
}
