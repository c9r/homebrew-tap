class GitHydrate < Formula
  desc "Large files in an object store, pointers in git, one copy on disk"
  homepage "https://github.com/c9r/git-hydrate"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.3/git-hydrate-aarch64-apple-darwin.tar.xz"
      sha256 "07a1fab68123162075a8ca1c323dfcbb19a64d03da55339798a0974ed01ffe04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.3/git-hydrate-x86_64-apple-darwin.tar.xz"
      sha256 "12dc4695f1aa7ecc3e00fc3c10191f821ff6aaa820d59c3570b827f444732896"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.3/git-hydrate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f430553bf4fae33105520f8a5c3749382e188a90c4792b9c06dfcb9a71af3dc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.3/git-hydrate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1d022236d8a140525a2bf5f290d41ad43b05ac46a3fd59c5715a9c4ded5d07cf"
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
