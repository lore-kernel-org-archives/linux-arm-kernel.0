From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Feb 2017 01:37:14 +0800
Subject: [PATCH 1/9] arm: sunxi: add support for R40 SoC
In-Reply-To: <20170217173722.6477-1-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
Message-ID: <20170217173722.6477-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 is a new SoC, with Quad Core Cortex-A7 and peripherals
like A20.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/arm/sunxi/README | 4 ++++
 arch/arm/mach-sunxi/sunxi.c    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index d7b1f016bd62..25c814adcd47 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -75,6 +75,10 @@ SunXi family
         + Datasheet
           http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
 
+      - Allwinner R40 (sun8i)
+        + Datasheet Draft
+          http://linux-sunxi.org/File:Allwinner_R40_Datasheet_V0.1.pdf
+
     * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
       - Allwinner A80
         + Datasheet
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index f44e3acb5c90..aea616759451 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -66,6 +66,7 @@ static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-h2-plus",
 	"allwinner,sun8i-h3",
 	"allwinner,sun8i-v3s",
+	"allwinner,sun8i-r40",
 	NULL,
 };
 
-- 
2.11.1
