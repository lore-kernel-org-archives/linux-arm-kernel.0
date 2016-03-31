From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 31 Mar 2016 14:44:59 +0800
Subject: [PATCH 0/2] dts/ls1043a: add the DTS node for QSPI support
Message-ID: <1459406701-40993-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

The QSPI controller on LS1043A is the same with the QSPI on LS1021A.
We shuld add the QSPI support on LS1043A.

So this patch try to add the dts node and binding Documentation.

Depend on the patch:
arm64: dts: add LS1043a-QDS board support
https://patchwork.kernel.org/patch/8528821/

Yuan Yao (2):
  Documentation: fsl-quadspi: Add fsl, ls1043a-qspi compatible string
  dts/ls1043a: add the DTS node for QSPI support

 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt |  3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts     | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi        | 14 ++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.1.0.27.g96db324
