From: yao.yuan@freescale.com (Yuan Yao)
Date: Tue, 8 Mar 2016 16:22:56 +0800
Subject: [PATCH v5 1/2] Documentation: fsl: dspi: Add fsl,
 ls2080a-dspi compatible string
Message-ID: <1457425377-6383-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

new compatible string: "fsl,ls2080a-dspi".

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changed in v5:
Fix the subject and commit message.

Changed in v4:
No changes.

Changed in v3:
Add the modifier for new compatible string like:
"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"

Changed in v2:
Update my email to <yao.yuan@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index fa77f87..1ad0fe3 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -1,7 +1,10 @@
 ARM Freescale DSPI controller
 
 Required properties:
-- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi", "fsl,ls2085a-dspi"
+- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
+		"fsl,ls2085a-dspi"
+		or
+		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
 - clocks: from common clock binding: handle to dspi clock.
-- 
2.1.0.27.g96db324
