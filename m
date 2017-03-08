From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Mar 2017 18:33:13 +0100
Subject: [PATCH 1/3] ARM64: dts: marvell: armada-37xx: Fix interrupt mapping
 for USB3
In-Reply-To: <20170308173315.28512-1-gregory.clement@free-electrons.com>
References: <20170308173315.28512-1-gregory.clement@free-electrons.com>
Message-ID: <20170308173315.28512-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ number for xhci controller was wrong, fix it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 7639518d8ee1..25ae5ccaf1bf 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -200,7 +200,7 @@
 				compatible = "marvell,armada3700-xhci",
 				"generic-xhci";
 				reg = <0x58000 0x4000>;
-				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-- 
2.11.0
