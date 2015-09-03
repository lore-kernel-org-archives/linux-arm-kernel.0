From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 12:20:40 +0530
Subject: [PATCH v2 4/6] ARM: dts: omap3: use "ti,
 pbias-omap3" compatible string for pbias
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Message-ID: <1441263042-12942-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "ti,pbias-omap3" compatible string which is specifically added
for OMAP3.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..9af9ae1 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -203,7 +203,7 @@
 		};
 
 		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
+			compatible = "ti,pbias-omap3", "ti,pbias-omap";
 			reg = <0x2b0 0x4>;
 			syscon = <&scm_conf>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
-- 
1.7.9.5
