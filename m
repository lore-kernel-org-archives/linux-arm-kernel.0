From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 21 Oct 2015 12:36:29 +0100
Subject: [GIT PULL] arm64: Juno: Add support for PCIe or R1 board
Message-ID: <20151021113629.GF3394@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please consider pulling the following commits for v4.4.

Best regards,
Liviu

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-ld for-upstream/juno-pcie

for you to fetch changes up to 5e7ab8c54ba0f9c9a6332201d00edc6965d44078:

  arm64: defconfig: Enable PCI generic host bridge by default (2015-10-16 15:59:53 +0100)

----------------------------------------------------------------
Liviu Dudau (3):
      Documentation: of: Document the bindings used by Juno R1 PCIe host bridge
      arm64: Juno: Add support for the PCIe host bridge on Juno R1
      arm64: defconfig: Enable PCI generic host bridge by default

 .../devicetree/bindings/pci/arm,juno-r1-pcie.txt     | 10 ++++++++++
 .../devicetree/bindings/pci/plda,xpressrich3-axi.txt | 12 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt          |  1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                  | 20 ++++++++++++++++++++
 arch/arm64/configs/defconfig                         |  1 +
 5 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
