From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Sep 2014 23:09:09 +0800
Subject: [PATCH] Documentation: sunxi: Update Allwinner SoC documentation
 (A31/A31s/A23)
Message-ID: <1411571349-30867-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lately we have received documentation for A31 and A31s, in addition to
A23 documentation which was received earlier but not added.

Add these to the README, and update to reflect that A31 and A23 are
supported.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/arm/sunxi/README | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index 7945238..57c4da6 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -37,15 +37,24 @@ SunXi family
           http://dl.linux-sunxi.org/A20/A20%20User%20Manual%202013-03-22.pdf
 
       - Allwinner A23
-        + Not Supported
+        + Datasheet
+          http://dl.linux-sunxi.org/A23/A23%20Datasheet%20V1.0%2020130830.pdf
+        + User Manual
+          http://dl.linux-sunxi.org/A23/A23%20User%20Manual%20V1.0%2020130830.pdf
 
     * Quad ARM Cortex-A7 based SoCs
       - Allwinner A31 (sun6i)
         + Datasheet
-          http://dl.linux-sunxi.org/A31/A31%20Datasheet%20-%20v1.00%20(2012-12-24).pdf
+          http://dl.linux-sunxi.org/A31/A3x_release_document/A31/IC/A31%20datasheet%20V1.3%2020131106.pdf
+        + User Manual
+          http://dl.linux-sunxi.org/A31/A3x_release_document/A31/IC/A31%20user%20manual%20V1.1%2020130630.pdf
 
       - Allwinner A31s (sun6i)
         + Not Supported
+        + Datasheet
+          http://dl.linux-sunxi.org/A31/A3x_release_document/A31s/IC/A31s%20datasheet%20V1.3%2020131106.pdf
+        + User Manual
+          http://dl.linux-sunxi.org/A31/A3x_release_document/A31s/IC/A31s%20User%20Manual%20%20V1.0%2020130322.pdf
 
     * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
       - Allwinner A80
-- 
2.1.0
