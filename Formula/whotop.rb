class Whotop < Formula
  desc "Who is your computer talking to? A btop-style terminal monitor focused on network connections, explained in plain English."
  homepage "https://github.com/ivedmohan/whotop"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ivedmohan/whotop/releases/download/v0.1.1/whotop-aarch64-apple-darwin.tar.xz"
      sha256 "83bda1482732e8de93ac3cbff79466cb952b41730027c9a21ad8cc7ccc52cff9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ivedmohan/whotop/releases/download/v0.1.1/whotop-x86_64-apple-darwin.tar.xz"
      sha256 "c751b3b5c8edaf5296fdc4f1b1670f376b8ea546e9ed0aa8b4d4a43d8a516028"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ivedmohan/whotop/releases/download/v0.1.1/whotop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a58b3c1ac5622ce4d0e83ca198894dbb5415ebb029a4d6c80e8deccf5a0fb49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ivedmohan/whotop/releases/download/v0.1.1/whotop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0bb56f86efc0bb1d27f45168ed2e4393a4e15e72962f53a10a13f126a8949f05"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "whotop"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "whotop"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "whotop"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "whotop"
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
