From: joelf@ti.com (Joel Fernandes)
Date: Mon, 30 Sep 2013 10:13:02 -0500
Subject: [PATCH v2 5/9] am33xx: dts: Fix AES interrupt number
In-Reply-To: <1380553986-15910-1-git-send-email-joelf@ti.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
Message-ID: <1380553986-15910-6-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0daa1b2..d7be90a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -724,7 +724,7 @@
 			compatible = "ti,omap4-aes";
 			ti,hwmods = "aes";
 			reg = <0x53500000 0xa0>;
-			interrupts = <102>;
+			interrupts = <103>;
 			dmas = <&edma 6
 				&edma 5>;
 			dma-names = "tx", "rx";
-- 
1.8.1.2
