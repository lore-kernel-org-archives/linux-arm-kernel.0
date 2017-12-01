From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Fri,  1 Dec 2017 08:41:22 +0100
Subject: [PATCH v4 1/2] DTS: GTA04: improve panel compatibility string
In-Reply-To: <cover.1512114082.git.hns@goldelico.com>
References: <cover.1512114082.git.hns@goldelico.com>
Message-ID: <280160905017f67c91b96bf38ea9b6094ec277c3.1512114082.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Official vendor string is now "tpo" and not "toppoly".

Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"
so that the driver understands both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4504908c23fe..ec27ed67a22a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -86,7 +86,7 @@
 
 		/* lcd panel */
 		lcd: td028ttec1 at 0 {
-			compatible = "toppoly,td028ttec1";
+			compatible = "tpo,td028ttec1";
 			reg = <0>;
 			spi-max-frequency = <100000>;
 			spi-cpol;
-- 
2.12.2
