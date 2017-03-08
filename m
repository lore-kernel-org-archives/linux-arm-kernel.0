From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Mar 2017 18:33:14 +0100
Subject: [PATCH 2/3] ARM64: dts: marvell: armada-37xx: Add clock resource for
 USB3
In-Reply-To: <20170308173315.28512-1-gregory.clement@free-electrons.com>
References: <20170308173315.28512-1-gregory.clement@free-electrons.com>
Message-ID: <20170308173315.28512-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that clocks are available provide a clock resource for xhci node.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 25ae5ccaf1bf..1df9d4e0d943 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -201,6 +201,7 @@
 				"generic-xhci";
 				reg = <0x58000 0x4000>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&sb_periph_clk 12>;
 				status = "disabled";
 			};
 
-- 
2.11.0
