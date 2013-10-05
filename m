From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  5 Oct 2013 16:17:54 +0200
Subject: [PATCH 2/4] Documentation: sunxi: Update Allwinner SoC documentation
In-Reply-To: <1380982676-10055-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380982676-10055-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1380982676-10055-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since that document was first submitted, some new SoCs have been
announced/released by Allwinner. Update the documentation to mention
those and the related documents.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/arm/sunxi/README | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index 4f3855f..7945238 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -10,6 +10,10 @@ SunXi family
   Linux kernel mach directory: arch/arm/mach-sunxi
 
   Flavors:
+    * ARM926 based SoCs
+      - Allwinner F20 (sun3i)
+        + Not Supported
+
     * ARM Cortex-A8 based SoCs
       - Allwinner A10 (sun4i)
         + Datasheet
@@ -25,4 +29,24 @@ SunXi family
         + Datasheet
 	  http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
         + User Manual
-          http://dl.linux-sunxi.org/A13/A13%20User%20Manual%20-%20v1.2%20%282013-01-08%29.pdf
\ No newline at end of file
+          http://dl.linux-sunxi.org/A13/A13%20User%20Manual%20-%20v1.2%20%282013-01-08%29.pdf
+
+    * Dual ARM Cortex-A7 based SoCs
+      - Allwinner A20 (sun7i)
+        + User Manual
+          http://dl.linux-sunxi.org/A20/A20%20User%20Manual%202013-03-22.pdf
+
+      - Allwinner A23
+        + Not Supported
+
+    * Quad ARM Cortex-A7 based SoCs
+      - Allwinner A31 (sun6i)
+        + Datasheet
+          http://dl.linux-sunxi.org/A31/A31%20Datasheet%20-%20v1.00%20(2012-12-24).pdf
+
+      - Allwinner A31s (sun6i)
+        + Not Supported
+
+    * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
+      - Allwinner A80
+        + Not Supported
\ No newline at end of file
-- 
1.8.4
