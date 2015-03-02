From: vigneshr@ti.com (Vignesh R)
Date: Mon, 2 Mar 2015 16:19:34 +0530
Subject: [PATCH v2 3/3] ARM: dts: AM4372: update hdq compatible property
In-Reply-To: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
Message-ID: <1425293374-30878-4-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates hdq node compatible property to "ti,am4372-hdq".

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1943fc333e7c..ae0e8c15a6df 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -884,7 +884,7 @@
 		};
 
 		hdq: hdq at 48347000 {
-			compatible = "ti,am43xx-hdq";
+			compatible = "ti,am4372-hdq";
 			reg = <0x48347000 0x1000>;
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&func_12m_clk>;
-- 
1.9.1
