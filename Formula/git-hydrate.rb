class GitHydrate < Formula
  desc "Large files in an object store, pointers in git, one copy on disk"
  homepage "https://github.com/c9r/git-hydrate"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-aarch64-apple-darwin.tar.xz"
      sha256 "a594f36b01f98c1cd4fd41c8e427f25609f964c0240d4af2180ce81e0e8a2cb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-x86_64-apple-darwin.tar.xz"
      sha256 "0d8573c79c9eebbf55798fb402da0529d929e0c2037172616157e4787a71cd5e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b78d645bc6deb82202db333e7c3219046c94392c78184bcdab1440a370d4dc34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/c9r/git-hydrate/releases/download/v0.1.1/git-hydrate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8ee78d15650b185fc593e58d0e2eb1a0acbe35699033b33bd66a4850c2e12dc"
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
