class GitHydrate < Formula
  desc "Large files in an object store, pointers in git, one copy on disk"
  homepage "https://github.com/c9r/git-hydrate"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-aarch64-apple-darwin.tar.xz"
      sha256 "0f5a065e92afd8f668199e35b45b3d17a9764a3d17a4b623a0d574f420246f3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-x86_64-apple-darwin.tar.xz"
      sha256 "e7a69ad3665b14f54df9cf41c365a6bc3fb48cf5cebc10076990a03ad83b2021"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a505e4e9c6d96a2d63d1c0433edab3f9f469dee825420f3793d268daf72cb29f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "90de3d544591409b629b3a53f6acaf6712eb0f0c8d89ec9455845c82d77cd774"
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
