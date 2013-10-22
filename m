From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 13:02:54 +0200
Subject: [PATCH] DTS: ARM: OMAP3-N900: Fix i2c bus speed
Message-ID: <1382439774-16265-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the bus speed of i2c bus 2 and 3.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 57f5a2a..2374b9a 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -78,14 +78,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
 
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 };
 
 &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
 
-	clock-frequency = <100000>;
+	clock-frequency = <400000>;
 };
 
 &mmc1 {
-- 
1.8.4.rc3
