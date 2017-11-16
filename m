From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu, 16 Nov 2017 09:50:18 +0100
Subject: [PATCH v2 3/4] DTS: Pandora: fix panel compatibility string
In-Reply-To: <cover.1510822218.git.hns@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com>
Message-ID: <f9e764c18a8fc77160ddea4fb61e63f703a0c19e.1510822218.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can remove the "omapdss," prefix because the
omapdrm driver takes care of it.

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
