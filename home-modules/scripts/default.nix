{ lib, ... }:
let

  scripts = {
    vimdir = ''
      #!/usr/bin/env bash
      set -e

      [[ -n "$1" ]] && cd "$1"
      FILE=$(fzf --preview='cat {+}')
      vim "$FILE"
    '';
    vimgrep = ''
      #!/usr/bin/env bash
      set -e

      [[ -n "$1" ]] && cd "$1"
      FILE=$(fzf --preview='cat {+}')
      vim "$FILE"
    '';
    nix-fancy-uninstall = ''
      #!/usr/bin/env bash
      nix-env -q | fzf | xargs -I{} nix-env -e {}
    '';
    stack-clean-all = ''
      #!/usr/bin/env bash
      find Dev -type d -name ".stack-work" -exec rm -rf {} \;
    '';
    nix-buildlog = ''
      #!/usr/bin/env bash
      if !(nix build $@ 2> /dev/null); then
        nix log $@
      fi
    '';
  };

  mkScript = name: text: {
    target = "bin/${name}";
    inherit text;
    executable = true;
  };

in { home = { file = lib.mapAttrs mkScript scripts; }; }
