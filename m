From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 12:20:41 +0530
Subject: [PATCH v2 5/6] ARM: dts: omap4: use "ti,
 pbias-omap4" compatible string for pbias
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Message-ID: <1441263042-12942-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "ti,pbias-omap4" compatible string which is specifically added
for OMAP4.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index abc4473..5aad7f3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -198,7 +198,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap4", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap4_padconf_global>;
 						pbias_mmc_reg: pbias_mmc_omap4 {
-- 
1.7.9.5
