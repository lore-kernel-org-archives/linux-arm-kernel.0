From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 25 Oct 2018 09:49:28 +0000
Subject: [PATCH v2 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
string list.

Hou Zhiqiang (4):
  dt-bindings: pci: layerscape-pci: add compatible strings
    "fsl,ls1043a-pcie"
  dt-bindings: pci: layerscape-pci: removed compatible string
    "snps,dw-pcie"
  dts/arm/ls1021a: Clean PCIe controller compatible strings
  dts/arm64/layerscape: Clean PCIe controller compatible strings

 .../devicetree/bindings/pci/layerscape-pci.txt       |  7 ++++---
 arch/arm/boot/dts/ls1021a.dtsi                       |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 12 ++++--------
 8 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.17.1
