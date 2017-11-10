From: xiaowei.bao@nxp.com (Bao Xiaowei)
Date: Fri, 10 Nov 2017 10:49:23 +0800
Subject: [PATCHv3 0/3]  dts: Add the property of IB and OB
Message-ID: <20171110024926.39700-1-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depend on http://patchwork.ozlabs.org/patch/815382/

Bao Xiaowei (3):
  ARMv8: dts: ls1046a: add the property of IB and OB
  ARMv8: layerscape: add the pcie ep function support
  ARMv8: pcie: make the DWC EP driver support for layerscape

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
 drivers/pci/dwc/Kconfig                        |   1 +
 drivers/pci/dwc/pci-layerscape.c               | 124 +++++++++++++++++++++++--
 3 files changed, 125 insertions(+), 6 deletions(-)

-- 
2.14.1
