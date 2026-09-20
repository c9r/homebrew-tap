class GitHydrate < Formula
  desc "Large files in an object store, pointers in git, one copy on disk"
  homepage "https://github.com/c9r/git-hydrate"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.2/git-hydrate-aarch64-apple-darwin.tar.xz"
      sha256 "b3f735d4164b30ac4d0942324619f5452dc4c23b8f06b4a4ab19e61fbe00f08e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.2/git-hydrate-x86_64-apple-darwin.tar.xz"
      sha256 "d93f000692e8922028dfee352aa04da34e8d1da2b373c111dbc881ef0c96e83d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.2/git-hydrate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "11aac3dbd8bae895a6f7455152c46e248c7f0ebbd821d95791a966a58e5bb2ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.2/git-hydrate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a20081ae6703d2205cf5d6812f3fe3a4d33eb5d2f3df9c0134f9c362c56a31b1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "git-dehydrate", "git-hydrate"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-dehydrate", "git-hydrate"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "git-dehydrate", "git-hydrate"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-dehydrate", "git-hydrate"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
