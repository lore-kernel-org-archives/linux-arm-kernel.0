From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 May 2013 10:53:32 +0200
Subject: [PATCH 1/2] ARM: sunxi: Update datasheet documentation
Message-ID: <1369385613-8166-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have access to more documentation now, especially the user manuals,
so add the links to them, and do so minor comestic changes while we're
at it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/arm/sunxi/README | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index 87a1e8f..d9a372d 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -3,17 +3,22 @@ ARM Allwinner SoCs
 
 This document lists all the ARM Allwinner SoCs that are currently
 supported in mainline by the Linux kernel. This document will also
-provide links to documentation and or datasheet for these SoCs.
+provide links to documentation and/or datasheet for these SoCs.
 
 SunXi family
 ------------
+  Linux kernel mach directory: arch/arm/mach-sunxi
 
   Flavors:
-        Allwinner A10 (sun4i)
-                Datasheet       : http://dl.linux-sunxi.org/A10/A10%20Datasheet%20-%20v1.21%20%282012-04-06%29.pdf
+    * ARM Cortex-A8 based SoCs
+      - Allwinner A10 (sun4i)
+        + Datasheet
+	  http://dl.linux-sunxi.org/A10/A10%20Datasheet%20-%20v1.21%20%282012-04-06%29.pdf
+	+ User Manual
+	  http://dl.linux-sunxi.org/A10/A10%20User%20Manual%20-%20v1.20%20%282012-04-09%2c%20DECRYPTED%29.pdf
 
-        Allwinner A13 (sun5i)
-                Datasheet       : http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
-
-  Core: Cortex A8
-  Linux kernel mach directory: arch/arm/mach-sunxi
\ No newline at end of file
+      - Allwinner A13 (sun5i)
+        + Datasheet
+	  http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
+        + User Manual
+	  http://dl.linux-sunxi.org/A13/A13%20User%20Manual%20-%20v1.2%20%282013-08-08%29.pdf
-- 
1.8.1.2
