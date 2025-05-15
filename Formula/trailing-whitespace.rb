class TrailingWhitespace < Formula
  desc "Provide files, we'll make sure there is one empty line at the end.  Simples."
  homepage "https://github.com/arembridge/trailing-whitespace"
  url "https://github.com/arembridge/trailing-whitespace/releases/download/v0.0.0/trailing-whitespace-macos"
  sha256 "ebc80cd99fdd834e6503207e0bb63de0532ab7d032ce1568a50ecf79482b7821"
  version "0.0.0"

  def install
    bin.install "trailing-whitespace-macos" => "trailing-whitespace"
  end
end
