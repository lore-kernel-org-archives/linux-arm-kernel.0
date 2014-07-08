From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue,  8 Jul 2014 20:40:52 +0200
Subject: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
In-Reply-To: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core complains that the number 343 is too large. The older code has
here 124. This avoids the warning, the driver hasn't been tested.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index daf7d36..1529bca 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -821,7 +821,7 @@
 			clocks = <&qspi_gfclk_div>;
 			clock-names = "fck";
 			num-cs = <4>;
-			interrupts = <0 343 0x4>;
+			interrupts = <0 124 0x4>;
 			status = "disabled";
 		};
 
-- 
2.0.1
