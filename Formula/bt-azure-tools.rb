# typed: strict
# frozen_string_literal: true

# Homebrew formula for BTAzureTools
# Copy this file to your homebrew-tap repository under Formula/bt-azure-tools.rb
class BtAzureTools < Formula
  desc "Azure SQL administration tools for managing Entra ID permissions and more"
  homepage "https://github.com/bt-pro-solutions/bt-azure-tools"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bt-pro-solutions/bt-azure-tools/releases/download/v#{version}/bt-azure-tools-osx-arm64.tar.gz"
      sha256 "4723484e05f7324e0b47c97110cdde7bf417cf33d833984b7284783504eca095"
    end

    on_intel do
      url "https://github.com/bt-pro-solutions/bt-azure-tools/releases/download/v#{version}/bt-azure-tools-osx-x64.tar.gz"
      sha256 "60696940425f387d4f5b1720ae0c21730f47602d7286a3d68b63a73b66c3f3cf"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "bt-azure-tools-osx-arm64" => "bt-azure-tools"
    else
      bin.install "bt-azure-tools-osx-x64" => "bt-azure-tools"
    end
  end

  def caveats
    <<~EOS
      BTAzureTools requires Azure CLI authentication.
      
      Before using, ensure you're logged into Azure:
        az login
      
      For usage information, run:
        bt-azure-tools --help
    EOS
  end

  test do
    assert_match "BTAzureTools", shell_output("#{bin}/bt-azure-tools --version", 0)
  end
end
