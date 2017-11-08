From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed,  8 Nov 2017 22:09:30 +0100
Subject: [PATCH 2/4] DTS: GTA04: fix panel compatibility string
In-Reply-To: <cover.1510175371.git.hns@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
Message-ID: <93a85b01b5a4b254469a3068a774ce2f38dc4e67.1510175371.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vendor string is "tpo" and not "toppoly".

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
