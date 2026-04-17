# This function takes `pkgs` (all Nix packages) as input
{ pkgs, ... }:

{
  # Import other config modules
  imports = [
    ./zsh.nix # Load our zsh configuration
  ];

  # User identity — used by Home Manager to know where to place files
  home.username = "georges.farah";
  home.homeDirectory = "/Users/georges.farah"; # On Linux/WSL use "/home/georges.farah"

  # Version of Home Manager state format — don't change this after initial setup
  home.stateVersion = "24.05";

  # Allow unfree packages (e.g., claude-code)
  nixpkgs.config.allowUnfree = true;

  # bat — a better `cat` with syntax highlighting and line numbers
  programs.bat.enable = true;

  # tmux — terminal multiplexer
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";
    plugins = with pkgs.tmuxPlugins; [
      sensible    # tmux-sensible — sane defaults (UTF-8, larger history, faster key repeat, etc.)
      catppuccin  # Catppuccin — pastel color theme for tmux
    ];
    extraConfig = ''
      unbind C-b
      bind C-a send-prefix
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
    '';
  };

  # Extra packages
  home.packages = [
    pkgs.claude-code # Claude Code CLI
    pkgs.nerd-fonts.fira-code # Nerd Font — FiraCode
    pkgs.nerd-fonts.jetbrains-mono # Nerd Font — JetBrains Mono
    pkgs.coreutils # GNU coreutils (ls, cp, mv, etc.)
    pkgs.go # Go programming language
    pkgs.nodejs # Node.js runtime
    pkgs.python3 # Python 3
    pkgs.cargo # Rust package manager
    pkgs.terraform # Terraform infrastructure-as-code CLI
    pkgs.protobuf # Protocol Buffers compiler (protoc)
  ]
  # macOS-only GUI apps
  ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
    pkgs.google-chrome # Google Chrome browser
    pkgs.iterm2 # iTerm2 terminal emulator
  ];

  # Shell cheatsheet — available at ~/.shell-cheatsheet.sh, searchable via Ctrl+H
  home.file.".shell-cheatsheet.sh".source = ./shell-cheatsheet.sh;

  # Let Home Manager manage itself (enables the `home-manager` CLI tool)
  programs.home-manager.enable = true;
}
