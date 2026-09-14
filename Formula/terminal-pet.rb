class TerminalPet < Formula
  desc "Animated pixel-art pet that lives on your terminal window and reacts to your shell"
  homepage "https://github.com/Zezoo123/terminal-pet"
  url "https://github.com/Zezoo123/terminal-pet/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "e4b281e3007700c785fdbc7dd08b309d78e68efa61f08babbcb7bfb0afdad043"
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
