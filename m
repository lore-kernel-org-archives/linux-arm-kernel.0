From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 1 Dec 2017 09:24:49 +0800
Subject: [PATCH v4 1/4] dt-bindings: clock: add compatible variant for the
 Meson-AXG
In-Reply-To: <20171201012452.27086-1-yixun.lan@amlogic.com>
References: <20171201012452.27086-1-yixun.lan@amlogic.com>
Message-ID: <20171201012452.27086-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the documentation to support clock driver for the Amlogic's
Meson-AXG SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 924040769186..e2b377ed6f91 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -5,8 +5,11 @@ controllers within the SoC.
 
 Required Properties:
 
-- compatible: should be "amlogic,gxbb-clkc" for GXBB SoC,
-	      or "amlogic,gxl-clkc" for GXL and GXM SoC.
+- compatible: should be:
+		"amlogic,gxbb-clkc" for GXBB SoC,
+		"amlogic,gxl-clkc" for GXL and GXM SoC,
+		"amlogic,axg-clkc" for AXG SoC.
+
 - reg: physical base address of the clock controller and length of memory
        mapped region.
 
-- 
2.15.0
