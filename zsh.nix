# This function takes `pkgs` (all Nix packages) as input
{ pkgs, ... }:

{
  # Enable and configure zsh as the shell
  programs.zsh = {
    enable = true;

    # Oh My Zsh — a framework that adds themes, plugins, and helpers to zsh
    oh-my-zsh = {
      enable = true;
      theme = ""; # Disabled — using Starship prompt instead

      # Plugins that come bundled with Oh My Zsh (no extra install needed)
      plugins = [
        "fzf"        # Fuzzy finder (Ctrl+R for history, Ctrl+T for files)
        "git"        # Git aliases (e.g., gst=git status, gco=git checkout)
        "web-search" # Search from terminal (e.g., `google nix tutorial`)
        "z"          # Jump to frequently visited directories (e.g., `z myproject`)
      ]
      # macOS-only plugins (require pbcopy)
      ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
        "copyfile"   # Run `copyfile <file>` to copy file contents to clipboard
        "copypath"   # Run `copypath` to copy current directory to clipboard
      ];
    };

    # Extra commands added to the end of .zshrc
    initContent = ''
      # Source Nix profile so Nix-installed binaries are on PATH
      # (needed on non-NixOS Linux where Nix is a standalone package manager)
      [ -f ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh

      # Set locale to English
      export LANG="en_US.UTF-8"
      export LC_ALL="en_US.UTF-8"

      # Add go install-ed binaries to PATH
      export PATH="$HOME/go/bin:$PATH"

      # Load machine-specific config (not managed by Nix)
      [ -f ~/.zshrc.local ] && source ~/.zshrc.local

      # Ctrl+H — fuzzy-search cheatsheet and insert selected line at cursor
      _cheatsheet() {
        local cmd
        cmd=$(grep -v '^\s*#\|^\s*$' ~/.shell-cheatsheet.sh | sed 's/[[:space:]]*#.*$//' | fzf --height 40% --reverse)
        LBUFFER+="$cmd"
        zle redisplay
      }
      zle -N _cheatsheet
      bindkey '^H' _cheatsheet
    '';

    # External plugins — these are NOT bundled with Oh My Zsh,
    # so we install them from nixpkgs separately
    plugins = [
      {
        name = "zsh-autosuggestions";             # Plugin name
        src = pkgs.zsh-autosuggestions;            # Nix package to install from
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh"; # Script to source
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];
  };

  # Starship — a fast, customizable prompt (replaces Oh My Zsh theme)
  # Config is in starship.toml (Jetpack preset with disabled language indicators)
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Use our custom starship.toml
  xdg.configFile."starship.toml".source = ./starship.toml;

  # Install fzf and hook it into zsh (required by the fzf plugin above)
  programs.fzf = {
    enable = true;              # Install the fzf binary
    enableZshIntegration = true; # Add fzf keybindings to zsh
  };
}
