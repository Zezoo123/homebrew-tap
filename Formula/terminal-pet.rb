class TerminalPet < Formula
  desc "Animated pixel-art pet that lives on your terminal window and reacts to your shell"
  homepage "https://github.com/Zezoo123/terminal-pet"
  url "https://github.com/Zezoo123/terminal-pet/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a1eec6b41ddf19f695ab8a95b94a8beaed2f02d1702184da1bbeab078402a41a"
  license "MIT"
  head "https://github.com/Zezoo123/terminal-pet.git", branch: "main"

  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/terminal-pet"
    (share/"terminal-pet").install "pets"
    (share/"terminal-pet").install "shell/terminal-pet.plugin.zsh", "shell/terminal-pet.plugin.bash", "shell/terminal-pet.fish"
  end

  def caveats
    <<~EOS
      Hook it into your shell (zsh, bash or fish), then open a new terminal:
        terminal-pet setup
      Start it with `terminal-pet`, stop it with `terminal-pet stop`.
    EOS
  end

  test do
    assert_match "terminal-pet", shell_output("#{bin}/terminal-pet --version")
    assert_match "blob", shell_output("#{bin}/terminal-pet pets")
  end
end
