From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 30 Aug 2017 18:12:35 +0800
Subject: [PATCHv2 0/3] arm64: dts: ls1012a: add the DTS node for DSPI support 
Message-ID: <20170830101238.28378-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Corrected the subject for 3/5 patch v1.

Yuan Yao (3):
  arm64: dts: ls1012a: add the DTS node for DSPI support
  Documentation: fsl: dspi: Add fsl,ls1012a-dspi compatible string
  Documentation: dt: mtd: add sst25wf040b and en25s64 to the SPI NOR
    support list

 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  2 ++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 33 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 13 +++++++++
 4 files changed, 49 insertions(+)

-- 
2.14.1
