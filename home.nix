{
  #secrets,
  pkgs,
  username,
  nix-index-database,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
    # FIXME: select your core binaries that you always want on the bleeding-edge
    bat
    bottom
    coreutils
    curl
    du-dust
    fd
    ffmpeg_7-full
    findutils
    firefox
    fx
    git
    git-crypt
    grex
    htop
    hyperfine
    inferno
    jaq
    jq
    killall
    logseq
    podman
    docker
    lazydocker
    lazygit
    mosh
    navi
    neofetch
    neovim
    nushell
    nushellPlugins.gstat
    nushellPlugins.gstat
    nushellPlugins.polars
    nushellPlugins.query
    ouch
    pixi
    procs
    ripgrep
    sd
    sox
    tealdeer
    tmux
    tree
    unzip
    vim
    vscode
    wget
    xcp
    zip
    tridactyl-native
    zellij
  ];

  stable-packages = with pkgs; [
    # FIXME: customize these stable packages to your liking for the languages that you use

    # FIXME: you can add plugins, change keymaps etc using (jeezyvim.nixvimExtend {})
    # https://github.com/LGUG2Z/JeezyVim#extending
    vimPlugins.nvchad
    vimPlugins.nvchad-ui

    # FIXME: disable this if you don't want to use the starship promp

    # FIXME: disable this if you don't want to use the starship prompt
    # key tools
    gh # for bootstrapping
    just
    
    #c/cpp
    cmake
    bazel
    ninja
    llvm
    gnumake
    clang
    
    # rust
    rustup
    
    ##more rusty things
    cargo-cache
    cargo-expand

    # local dev stuf
    mkcert
    httpie

    # treesitter
    tree-sitter

    # language servers
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    nil # nix

    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
    
    #term
    wezterm

  ];
in {
  imports = [
    nix-index-database.hmModules.nix-index
    ./xfce-home.nix
  ];

  home.stateVersion = "24.05";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    # FIXME: set your preferred $SHELL
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/nu";
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    # FIXME: you can add anything else that doesn't fit into the above two lists in here
    ++[
      # pkgs.some-package
      # pkgs.unstable.some-other-package
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    ];

  fonts.fontconfig.enable = true;
  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;


    # FIXME: disable whatever you don't want
    fzf.enable = true;
    skim.enable = true;
    eza.enable = true;
    #eza.enableNushellIntegration = true;
    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;
    zoxide.options = ["--cmd cd"];
    broot.enable = true;
    broot.enableNushellIntegration = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    direnv.enableNushellIntegration = true;
    thefuck.enable = true;
    thefuck.enableNushellIntegration = true;
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    git = {
      enable = true;
      package = pkgs.unstable.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "johannestoke@gmail.com"; # FIXME: set your git email
      userName = "johtok"; #FIXME: set your git username
      extraConfig = {
        # FIXME: uncomment the next lines if you want to be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };
  };
}
