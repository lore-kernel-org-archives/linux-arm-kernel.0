From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:14:15 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new RTC compatibles
In-Reply-To: <1391807655-29169-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391807655-29169-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391807655-29169-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the RTC drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 26cf191..6065528 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -431,7 +431,7 @@
 		};
 
 		rtc: rtc at 01c20d00 {
-			compatible = "allwinner,sun4i-rtc";
+			compatible = "allwinner,sun4i-a10-rtc";
 			reg = <0x01c20d00 0x20>;
 			interrupts = <24>;
 		};
-- 
1.8.4.2
