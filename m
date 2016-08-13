From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 13 Aug 2016 18:01:13 +0800
Subject: [PATCH v2] Documentation: sunxi: Update Allwinner SoC documentation
Message-ID: <20160813100113.3756-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, the A83T and A64 SoC user manuals are available.
Update the documentation to add the links.

An updated version of A83T datasheet is also included now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Add updated A83T Datasheet.

 Documentation/arm/sunxi/README | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index e5a115f..c7a0554 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -73,4 +73,13 @@ SunXi family
     * Octa ARM Cortex-A7 based SoCs
       - Allwinner A83T
         + Datasheet
-          http://dl.linux-sunxi.org/A83T/A83T_datasheet_Revision_1.1.pdf
+          https://github.com/allwinner-zh/documents/raw/master/A83T/A83T_Datasheet_v1.3_20150510.pdf
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
2.9.2
