From: jian.hu@amlogic.com (Jian Hu)
Date: Mon, 9 Jul 2018 19:12:45 +0800
Subject: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A SoC
In-Reply-To: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
Message-ID: <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new binding for Meson-G12A SoC Everything-Else part

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index e950599..0833006 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -9,6 +9,7 @@ Required Properties:
 		"amlogic,gxbb-clkc" for GXBB SoC,
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
+		"amlogic,g12a-clkc" for G12A SoC.
 
 - #clock-cells: should be 1.
 
-- 
1.9.1
