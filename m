From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed,  8 Nov 2017 22:09:31 +0100
Subject: [PATCH 3/4] DTS: Pandora: fix panel compatibility string
In-Reply-To: <cover.1510175371.git.hns@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
Message-ID: <444424119f30b6e1b1e56456b870e8492b9acad6.1510175371.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can remove the "omapdss," prefix.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 53e007abdc71..64d967ec8c58 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -626,7 +626,7 @@
 
 	lcd: lcd at 1 {
 		reg = <1>;	/* CS1 */
-		compatible =	"omapdss,tpo,td043mtea1";
+		compatible =	"tpo,td043mtea1";
 		spi-max-frequency = <100000>;
 		spi-cpol;
 		spi-cpha;
-- 
2.12.2
