From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Sep 2015 17:09:46 +0200
Subject: [PATCH 1/2] sama5d33ek: enable led D3
Message-ID: <27620a5315a0fd314e21eac4afbfe87f1350b099.1441897573.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/boot/dts/sama5d33ek.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
index cbd6a3ff1545..48d7445828dd 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -39,6 +39,13 @@
 		};
 	};
 
+	leds {
+		d3 {
+			label = "d3";
+			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	sound {
 		status = "okay";
 	};
-- 
2.1.3
