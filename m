From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  2 Aug 2016 20:01:17 +0800
Subject: [PATCH] Documentation: sunxi: Update Allwinner SoC documentation
Message-ID: <20160802120117.4848-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, the A83T and A64 SoC user manuals are available.
Update the documentation to add the links.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/arm/sunxi/README | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index e5a115f..302d947 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -74,3 +74,12 @@ SunXi family
       - Allwinner A83T
         + Datasheet
           http://dl.linux-sunxi.org/A83T/A83T_datasheet_Revision_1.1.pdf
+        + User Manual
+          https://github.com/allwinner-zh/documents/raw/master/A83T/A83T_User_Manual_v1.5.1_20150513.pdf
+
+    * Quad ARM Cortex-A53 based SoCs
+      - Allwinner A64
+        + Datasheet
+          http://dl.linux-sunxi.org/A64/A64_Datasheet_V1.1.pdf
+        + User Manual
+          http://dl.linux-sunxi.org/A64/Allwinner%20A64%20User%20Manual%20v1.0.pdf
-- 
2.9.0
