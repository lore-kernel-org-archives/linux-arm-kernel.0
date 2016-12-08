From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 8 Dec 2016 17:22:59 +0800
Subject: [PATCH 0/5] arm64: dts: ls1012a: add the DTS node for QSPI/DSPI
 support
Message-ID: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

LS1012A also support QSPI and DSPI.
This patch set is used to add the QSPI/DSPI node for LS1012A.

This patch set is depend on the patch for add LS1012A platform dts support:
arm64: Add DTS support for FSL's LS1012A SoC

The patchwork link:
https://patchwork.kernel.org/patch/9462399/

Yuan Yao (5):
  arm64: dts: ls1012a: add the DTS node for DSPI support
  Documentation: fsl: dspi: Add fsl,ls1012a-dspi compatible string
  Documentation: dt: mtd: add chip support for "jedec, spi-nor"
  arm64: dts: ls1012a: add the DTS node for QSPI support
  Documentation: fsl-quadspi: Add fsl,ls1012a-qspi compatible string

 .../devicetree/bindings/mtd/fsl-quadspi.txt        |  1 +
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  2 +
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 14 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 48 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 15 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 28 +++++++++++++
 7 files changed, 109 insertions(+)

-- 
2.1.0.27.g96db324
