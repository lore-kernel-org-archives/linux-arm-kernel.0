From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:56 +0100
Subject: [PATCH 3/6] ARM: dts: Add max98089 to exynos5250-spring
In-Reply-To: <1424283959-16289-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
Message-ID: <1424283959-16289-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index d075a68ac078..866beb4e0597 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -400,6 +400,11 @@
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <66000>;
 
+	max98089: codec at 10 {
+		compatible = "maxim,max98089", "maxim,max98088";
+		reg = <0x10>;
+	};
+
 	temperature-sensor at 4c {
 		compatible = "gmt,g781";
 		reg = <0x4c>;
-- 
2.1.4
