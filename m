From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed,  7 Aug 2013 09:14:15 -0500
Subject: [PATCH] ARM: dts: omap3-beagle-xm: fix string error in compatible
 property
Message-ID: <1375884855-19414-1-git-send-email-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index afdb164..0c514dc 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard xM";
-	compatible = "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
+	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
 
 	cpus {
 		cpu at 0 {
-- 
1.7.10.4
