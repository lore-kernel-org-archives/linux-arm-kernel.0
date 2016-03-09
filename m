From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 9 Mar 2016 18:22:04 +0800
Subject: [PATCH v6 0/2] dts/ls2080a: update the DTS for QSPI and DSPI support
Message-ID: <1457518926-18518-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Both of the patches are already send out to l2-mtd as a part of the set
for add QSPI support on Freescale new SOC before.

But those two patch should not be merged into l2-mtd, so I have to resend them.

Yuan Yao (2):
  dts/ls2080a: update the DTS for QSPI and DSPI support
  Documentation: fsl: dspi: Add fsl,ls2080a-dspi compatible string

 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 5 ++++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts      | 9 ++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi         | 4 ++--
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.1.0.27.g96db324
