From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  9 Jun 2013 18:36:02 +0200
Subject: [PATCH 1/6] ARM: sunxi: Add Allwinner A10s machine compatible
In-Reply-To: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1370795767-9769-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s is a SoC member of the Allwinner sun5i family. It is basically
an A13 with an EMAC and an HDMI controller.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/arm/sunxi/README | 4 ++++
 arch/arm/mach-sunxi/sunxi.c    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index d9a372d..e3f93fb 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -17,6 +17,10 @@ SunXi family
 	+ User Manual
 	  http://dl.linux-sunxi.org/A10/A10%20User%20Manual%20-%20v1.20%20%282012-04-09%2c%20DECRYPTED%29.pdf
 
+      - Allwinner A10s (sun5i)
+        + Datasheet
+          http://dl.linux-sunxi.org/A10s/A10s%20Datasheet%20-%20v1.20%20%282012-03-27%29.pdf
+
       - Allwinner A13 (sun5i)
         + Datasheet
 	  http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 08937a3..a42d874 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -109,6 +109,7 @@ static void __init sunxi_dt_init(void)
 
 static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
+	"allwinner,sun5i-a10s",
 	"allwinner,sun5i-a13",
 	NULL,
 };
-- 
1.8.3
