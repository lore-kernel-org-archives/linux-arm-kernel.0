From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 12:20:39 +0530
Subject: [PATCH v2 3/6] ARM: dts: omap243x: use "ti,
 pbias-omap2" compatible string for pbias
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Message-ID: <1441263042-12942-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "ti,pbias-omap2" compatible string which is specifically added
for OMAP2.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2430.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 2390f38..3961a6f 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -63,7 +63,7 @@
 					};
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap2", "ti,pbias-omap";
 						reg = <0x230 0x4>;
 						syscon = <&scm_conf>;
 						pbias_mmc_reg: pbias_mmc_omap2430 {
-- 
1.7.9.5
