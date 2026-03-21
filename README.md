# nixos-config

Nix configuration files managed with [Home Manager](https://nix-community.github.io/home-manager/).

## Install Nix

### macOS / Linux

```sh
curl -L https://nixos.org/nix/install | sh
```

After installation, restart your terminal.

### Install Home Manager

Once Nix is installed, register the Home Manager channel:

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
```

This adds the Home Manager GitHub repo as a Nix "channel" (a package source URL that Nix can fetch from).

Download the latest snapshot from all registered channels:

```sh
nix-channel --update
```

Run the Home Manager installer:

```sh
nix-shell '<home-manager>' -A install
```

This creates a temporary shell with the Home Manager dependencies, runs the install script, and sets up the `home-manager` CLI tool.

## Usage

This repo includes a ready-to-use `home.nix`. Before applying, update it with your own username and home directory:

- **macOS**: `home.homeDirectory = "/Users/your-username";`
- **Linux / WSL**: `home.homeDirectory = "/home/your-username";`

```nix
home.username = "your-username";
home.homeDirectory = "/Users/your-username";
```

Then apply:

```sh
home-manager switch -f ./home.nix -b backup
```

- `-f` points to your custom `home.nix` instead of the default location (`~/.config/home-manager/home.nix`)
- `-b backup` renames any conflicting files (like `.zshrc`) with a `.backup` suffix instead of failing

## Modules

### zsh.nix

Configures zsh with Oh My Zsh and the following plugins:

| Plugin | Source | Description |
|--------|--------|-------------|
| copyfile | Oh My Zsh | Copy file contents to clipboard |
| copypath | Oh My Zsh | Copy current directory path to clipboard |
| fzf | Oh My Zsh | Fuzzy finder integration |
| git | Oh My Zsh | Git aliases and completions |
| web-search | Oh My Zsh | Search Google/DuckDuckGo/etc. from terminal |
| z | Oh My Zsh | Jump to frequent directories |
| zsh-autosuggestions | nixpkgs | Inline command suggestions as you type |
| zsh-syntax-highlighting | nixpkgs | Color-codes commands (green=valid, red=invalid) |

Also installs and integrates [fzf](https://github.com/junegunn/fzf).

Also:
- Uses [Starship](https://starship.rs/) as the prompt theme (Tokyo Night preset, language indicators disabled)
- Sources `~/.zshrc.local` if it exists — use this for machine-specific config (e.g., work SSH keys, Homebrew, env variables) that shouldn't be committed to git

### home.nix

Also installs:

| Tool | Description |
|------|-------------|
| [bat](https://github.com/sharkdp/bat) | A better `cat` with syntax highlighting and line numbers |
| [Claude Code](https://claude.com/claude-code) | Anthropic's CLI for Claude |
| [FiraCode Nerd Font](https://www.nerdfonts.com/) | Monospace font with ligatures and icons |
| [JetBrains Mono Nerd Font](https://www.nerdfonts.com/) | Monospace font optimized for reading code |
| [GNU coreutils](https://www.gnu.org/software/coreutils/) | GNU versions of ls, cp, mv, etc. |
| [Go](https://go.dev/) | Go programming language |
| [Google Chrome](https://www.google.com/chrome/) | Google Chrome browser (macOS only) |
| [iTerm2](https://iterm2.com/) | Terminal emulator (macOS only) |
| [Node.js](https://nodejs.org/) | JavaScript runtime |
| [Python 3](https://www.python.org/) | Python programming language |

After activating, set the font in your terminal: **iTerm2 > Settings > Profiles > Text > Font** → select "FiraCode Nerd Font" or "JetBrainsMono Nerd Font".
