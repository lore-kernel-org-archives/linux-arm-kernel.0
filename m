From: joelf@ti.com (Joel Fernandes)
Date: Wed, 25 Sep 2013 17:01:05 -0500
Subject: [PATCH 5/9] am33xx: dts: Fix AES interrupt number
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Message-ID: <1380146469-29496-6-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 96c4b44..1a5575d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -726,7 +726,7 @@
 			ti,hwmods = "aes";
 			reg = <0x53500000 0xa0>;
 			interrupt-parent = <&intc>;
-			interrupts = <102>;
+			interrupts = <103>;
 			dmas = <&edma 6
 				&edma 5>;
 			dma-names = "tx", "rx";
-- 
1.8.1.2
