From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 17 Jan 2017 17:32:34 +0800
Subject: [PATCH v3 0/9] irqchip/ls-scfg-msi: Update MSI driver
Message-ID: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to update Layerscape MSI driver.
1. fix the compatible strings typo
2. Add MSI support to LS1046a
3. Add MSI support to LS1043a v1.1
4. Add MSI affinity support

Minghuan Lian (9):
  irqchip/ls-scfg-msi: fix typo of MSI compatible strings
  arm: dts: ls1021a: fix typo of MSI compatible string
  arm64: dts: ls1043a: fix typo of MSI compatible string
  arm: dts: ls1021a: share all MSIs
  arm64: dts: ls1043a: share all MSIs
  arm64: dts: ls1046a: add MSI dts node
  irqchip/ls-scfg-msi: add LS1046a MSI support
  irqchip/ls-scfg-msi: add LS1043a v1.1 MSI support
  irqchip/ls-scfg-msi: add MSI affinity support

 .../interrupt-controller/fsl,ls-scfg-msi.txt       |   8 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   8 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  12 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  31 +++
 drivers/irqchip/irq-ls-scfg-msi.c                  | 256 ++++++++++++++++++---
 5 files changed, 268 insertions(+), 47 deletions(-)

-- 
1.9.1
