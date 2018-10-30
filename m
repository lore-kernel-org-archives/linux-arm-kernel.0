From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 30 Oct 2018 15:28:11 +0000
Subject: [PATCH 1/2] dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible
 string
Message-ID: <1540913007-28343-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp compatible string

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c at vger.kernel.org
Cc: devicetree at vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
index 091c8df..b245363 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible :
   - "fsl,imx7ulp-lpi2c" for LPI2C compatible with the one integrated on i.MX7ULP soc
+  - "fsl,imx8qxp-lpi2c" for LPI2C compatible with the one integrated on i.MX8QXP soc
 - reg : address and length of the lpi2c master registers
 - interrupts : lpi2c interrupt
 - clocks : lpi2c clock specifier
-- 
2.7.4
