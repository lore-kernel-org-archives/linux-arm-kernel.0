From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 13 Apr 2016 18:08:25 +0800
Subject: [PATCH v2 0/2] arm64: dts: ls1043a: add the DTS node for QSPI support
Message-ID: <1460542107-45807-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Yuan Yao (2):
  Documentation: fsl-quadspi: Add fsl, ls1043a-qspi compatible string
	Changed in v2: Remove unused property.
  arm64: dts: ls1043a: add the DTS node for QSPI support

 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt |  3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts     | 13 +++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi        | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.1.0.27.g96db324
