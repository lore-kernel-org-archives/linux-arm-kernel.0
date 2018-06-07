From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Thu,  7 Jun 2018 21:11:32 +0900
Subject: [PATCH/RFT 0/2] Add PCIe support for r8a77965
Message-ID: <1528373494-18503-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds PCIe support for r8a77965 (R-Car M3-N).
It is not necessary to update driver and PFC.

This series is based on the devel branch of Simon Horman's renesas tree.

Takeshi Kihara (1):
  arm64: dts: renesas: r8a77965: Add PCIe device nodes

Yoshihiro Kaneko (1):
  PCI: rcar: Add compatible string for r8a77965

 Documentation/devicetree/bindings/pci/rcar-pci.txt |  1 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 48 +++++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
1.9.1
