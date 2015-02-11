From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Feb 2015 16:18:49 +0100
Subject: [PATCH 1/2] ARM: at91/dt: sama5d4: add missing alias for i2c0
Message-ID: <1423667929-29444-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index d986b41b9654..97d5b9759c07 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -66,6 +66,7 @@
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
 		i2c2 = &i2c2;
 	};
 	cpus {
-- 
2.1.3
