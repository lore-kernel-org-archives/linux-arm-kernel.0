From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 22 Aug 2017 13:23:21 +0800
Subject: [PATCH v2 2/3] ARM: sunxi: fix the core number of V3s in sunxi README
In-Reply-To: <20170822052322.15338-1-icenowy@aosc.io>
References: <20170822052322.15338-1-icenowy@aosc.io>
Message-ID: <20170822052322.15338-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner V3s SoC is not quad-core, but single-core.

Fix this in the README file.

Fixes: b074fede01c0 ("arm: sunxi: add support for V3s SoC")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/arm/sunxi/README | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index d7b1f016bd62..de791e18ccef 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -33,6 +33,11 @@ SunXi family
 
       - Next Thing Co GR8 (sun5i)
 
+    * Single ARM Cortex-A7 based SoCs
+      - Allwinner V3s (sun8i)
+        + Datasheet
+          http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
+
     * Dual ARM Cortex-A7 based SoCs
       - Allwinner A20 (sun7i)
         + User Manual
@@ -71,10 +76,6 @@ SunXi family
         + Datasheet
           http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
 
-      - Allwinner V3s (sun8i)
-        + Datasheet
-          http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
-
     * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
       - Allwinner A80
         + Datasheet
-- 
2.13.5
