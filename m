From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Sat, 13 Dec 2014 02:46:46 +0100
Subject: [PATCH 1/3] ARM: mx5: dts: remove unused irq-trigger entry
In-Reply-To: <cover.1418434448.git.silvio.fricke@gmail.com>
References: <cover.1418434448.git.silvio.fricke@gmail.com>
Message-ID: <73b964064f87e3e632cc251894c130b88aaaf0b8.1418434448.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/imx53-m53.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index 87a7fc7..8a5acb5 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -60,7 +60,6 @@
 		blocks = <0x5>;
 		interrupts = <6 0x0>;
 		interrupt-parent = <&gpio7>;
-		irq-trigger = <0x1>;
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-- 
2.1.3
