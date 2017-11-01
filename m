From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 1 Nov 2017 11:40:15 +0800
Subject: [PATCH 2/2] Documentation: fsl: dspi: Add a compatible string for
 ls1088a DSPI
In-Reply-To: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
References: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20171101034015.41114-3-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add a new compatible string "fsl,ls1088a-dspi".

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index dcc7eaada511..5fc467211cc6 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -6,6 +6,7 @@ Required properties:
 		or
 		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
 		"fsl,ls1012a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
+		"fsl,ls1088a-dspi" followed by "fsl,ls2085a-dspi"
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
 - clocks: from common clock binding: handle to dspi clock.
-- 
2.14.1
