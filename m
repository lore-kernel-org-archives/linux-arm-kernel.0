From: nikhil.badola@freescale.com (Nikhil Badola)
Date: Thu, 23 Jul 2015 15:42:58 +0530
Subject: [PATCH 3/3] arm: dts: ls1021a: Add snps,
 configure-gfladj property to USB3 node
Message-ID: <1437646378-1910-1-git-send-email-nikhil.badola@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "snps,configure-gfladj" boolean property to USB3 node. This property
is used to determine if frame length adjustment is required

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..f03f842 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -404,6 +404,7 @@
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			snps,configure-fladj = <0x20>;
 		};
 	};
 };
-- 
2.1.0
