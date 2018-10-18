From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 18:19:34 +0000
Subject: [PATCH V3 5/8] dt-bindings: spi: lpspi: add imx8qxp compatible string
In-Reply-To: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539886483-15775-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp compatible string

Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-spi at vger.kernel.org
Cc: devicetree at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 4af1326..8d178a4 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible :
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
+  - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX8QXP soc
 - reg : address and length of the lpspi master registers
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
-- 
2.7.4
