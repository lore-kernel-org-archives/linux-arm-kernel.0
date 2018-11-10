From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:48:10 +0000
Subject: [PATCH V4 1/5] dt-bindings: serial: lpuart: add imx8qxp compatible
 string
In-Reply-To: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
References: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541864596-15958-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp compatible string

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial at vger.kernel.org
Cc: devicetree at vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 6bd3f2e..21483ba 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -8,6 +8,8 @@ Required properties:
     on LS1021A SoC with 32-bit big-endian register organization
   - "fsl,imx7ulp-lpuart" for lpuart compatible with the one integrated
     on i.MX7ULP SoC with 32-bit little-endian register organization
+  - "fsl,imx8qxp-lpuart" for lpuart compatible with the one integrated
+    on i.MX8QXP SoC with 32-bit little-endian register organization
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- 
2.7.4
