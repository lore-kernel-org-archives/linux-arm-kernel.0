From: ruchika.gupta@freescale.com (Ruchika Gupta)
Date: Fri, 3 Jul 2015 15:47:02 +0530
Subject: [PATCH] ARM: ls1021a: dtsi: Add crypto node alias in device tree
Message-ID: <1435918622-19121-1-git-send-email-ruchika.gupta@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-boot patches up the device tree crypto node for the era property.

Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..1a99724 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -60,6 +60,7 @@
 		serial4 = &lpuart4;
 		serial5 = &lpuart5;
 		sysclk = &sysclk;
+		crypto = &crypto;
 	};
 
 	cpus {
-- 
1.8.1.4
