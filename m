From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:49 -0300
Subject: [PATCH 12/14] ARM: mvebu: Remove device tree unused properties on A370
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-13-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These properties are not needed so it's safe to remove them.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 1b11f1f..4fd483f 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -188,10 +188,6 @@
 
 				bus-range = <0x00 0xff>;
 
-				reg = <0x40000 0x2000>, <0x80000 0x2000>;
-
-				reg-names = "pcie0.0", "pcie1.0";
-
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
 					0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
 					0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-- 
1.8.1.5
