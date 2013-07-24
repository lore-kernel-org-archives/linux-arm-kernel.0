From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 24 Jul 2013 12:05:16 -0500
Subject: ARM: dts: omap3-beagle-xm: fix compatible property
Message-ID: <CAOCHtYhN4oO=xq9LcjZHCAUbSwQgTs2zEUJND1G7EbPNJ1njpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Guys,

While working on the device tree for the xM i noticed this little
error on the compatible property...

Thoughts?

>From af8e3119ae2ee29bcf739d56168d6aaa3a2c8306 Mon Sep 17 00:00:00 2001
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 24 Jul 2013 12:02:11 -0500
Subject: [PATCH] ARM: dts: omap3-beagle-xm: fix compatible property

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts
b/arch/arm/boot/dts/omap3-beagle-xm.dts
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


-- 
Robert Nelson
http://www.rcn-ee.com/
