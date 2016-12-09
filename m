From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri,  9 Dec 2016 15:28:30 +0900
Subject: [PATCH 1/4] ARM: dts: am335x: Fix the interrupt name of TPS65217
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Message-ID: <20161209062833.5768-2-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'interrupt-names' for getting the charger interrupt number.

Fixes: 1934e89a769b ("ARM: dts: am335x: Add the charger interrupt")
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index dc561d5..14b6269 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -320,7 +320,7 @@
 
 	charger {
 		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
-		interrupts-names = "AC", "USB";
+		interrupt-names = "AC", "USB";
 		status = "okay";
 	};
 
-- 
2.9.3
