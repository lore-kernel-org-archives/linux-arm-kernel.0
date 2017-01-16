From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 02:01:13 +0800
Subject: [PATCH v2 1/4] arm: sunxi: add support for V3s SoC
Message-ID: <20170116180116.36729-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s is a low-end single-core Cortex-A7 SoC, with 64MB
integrated DRAM, and several peripherals.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Used linux-sunxi.org wiki hosted address of V3s datasheet.

Note: the V3s datasheet contains its user manual.

 Documentation/arm/sunxi/README | 4 ++++
 arch/arm/mach-sunxi/sunxi.c    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index cd0243302bc1..a455b305c62c 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -67,6 +67,10 @@ SunXi family
         + Datasheet
           http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
 
+      - Allwinner V3s (sun8i)
+        + Datasheet
+          http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
+
     * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
       - Allwinner A80
         + Datasheet
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 2e2bde271205..f246bfc6cfe4 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -64,6 +64,7 @@ static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-a33",
 	"allwinner,sun8i-a83t",
 	"allwinner,sun8i-h3",
+	"allwinner,sun8i-v3s",
 	NULL,
 };
 
-- 
2.11.0
