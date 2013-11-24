From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 19:07:45 -0500
Subject: [PATCH 1/2] ARM: dts: OMAP5: Add maintenance interrupt for
 virtualisation
In-Reply-To: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385251666-27532-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a maintenance IRQ using PPI 9 to OMAP5 device tree
needed for virtualisation.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..c9f1ae4 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -74,6 +74,7 @@
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
+		interrupts = <1 9 0x304>;
 	};
 
 	/*
-- 
1.7.9.5
