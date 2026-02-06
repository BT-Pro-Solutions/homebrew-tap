# typed: strict
# frozen_string_literal: true

# Homebrew formula for BTAzureTools
# Copy this file to your homebrew-tap repository under Formula/bt-azure-tools.rb
class BtAzureTools < Formula
  desc "Azure SQL administration tools for managing Entra ID permissions and more"
  homepage "https://github.com/bt-pro-solutions/bt-azure-tools"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bt-pro-solutions/bt-azure-tools/releases/download/v#{version}/bt-azure-tools-osx-arm64.tar.gz"
      sha256 "be14433d10d022637f262d3991cf6f6529268158ff773ad23607a1853314ad4b"
    end

    on_intel do
      url "https://github.com/bt-pro-solutions/bt-azure-tools/releases/download/v#{version}/bt-azure-tools-osx-x64.tar.gz"
      sha256 "f169e7227d0a82035bfd8d695bce069628b8161acdac84f85debe7b34b2b26e5"
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
