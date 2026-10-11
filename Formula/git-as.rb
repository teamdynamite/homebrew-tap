class GitAs < Formula
  desc "Switch git identities between saved profiles"
  homepage "https://github.com/teamdynamite/git-as"
  url "https://github.com/teamdynamite/git-as/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "bab22535d6c131caa3f1f213c5cd7fd8f22c6f21896086659194030673b58555"
  license "Unlicense"
  head "https://github.com/teamdynamite/git-as.git", branch: "main"

  bottle do
    root_url "https://github.com/teamdynamite/homebrew-tap/releases/download/git-as-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d82598b6894725e13afd2a598050abd785b48d377db92085ea15a63bce7a647d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ff601002d25222964296c3e7cfd8dcdb342753966422c0c92ee71d318e2a8894"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    ENV["HOME"] = testpath
    ENV["GIT_CONFIG_NOSYSTEM"] = "1"

    assert_match "usage: git as", shell_output("#{bin}/git-as -h")

    system bin/"git-as", "add", "frank", "--name", "Frank Reynolds", "--email", "frank@example.com"
    system bin/"git-as", "add", "mantis", "--name", "Mantis Toboggan", "--email", "mantis@example.com"
    output = shell_output("#{bin}/git-as list")
    assert_match "Frank Reynolds <frank@example.com>", output
    assert_match "Mantis Toboggan <mantis@example.com>", output

    system bin/"git-as", "mantis"
    assert_equal "mantis@example.com", shell_output("git config --global user.email").chomp
    system bin/"git-as", "frank"
    assert_equal "Frank Reynolds", shell_output("git config --global user.name").chomp
    assert_match(/^\* frank/, shell_output("#{bin}/git-as list"))
  end
end
